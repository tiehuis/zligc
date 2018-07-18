// Corresponds to <stdio.h>

const std = @import("std");
const builtin = @import("builtin");
const cstr = std.cstr;
const File = std.os.File;

const c = @cImport({
    @cInclude("stdio.h");
});

// File access

var stdin_file: File = undefined;
export var stdin = &stdin_file;

var stdout_file: File = undefined;
export var stdout = &stdout_file;

var stderr_file: File = undefined;
export var stderr = &stderr_file;

var allocator = std.debug.global_allocator;

var resolved: u8 = 0;

fn initStreams() void {
    @setCold(true);

    stdin_file = std.io.getStdIn() catch unreachable;
    stdout_file = std.io.getStdOut() catch unreachable;
    stderr_file = std.io.getStdErr() catch unreachable;
}

inline fn readOpaqueHandle(handle: ?*c.FILE) *File {
    // TODO: workaround since passing resolved directly to @cmpxchgStrong treats it as comptime
    var non_comptime_resolved = &resolved;

    if (@cmpxchgStrong(u8, non_comptime_resolved, 0, 1, builtin.AtomicOrder.SeqCst, builtin.AtomicOrder.SeqCst)) |_| {
        @noInlineCall(initStreams);
    }

    return @ptrCast(*File, @alignCast(@alignOf(File), handle.?));
}

export fn fopen(filename: [*]const u8, mode: [*]const u8) ?*c.FILE {
    var fd = allocator.create(File(undefined)) catch return null;
    fd.* = File.openWrite(allocator, cstr.toSliceConst(filename)) catch return null;
    return @ptrCast(?*c.FILE, fd);
}

export fn fclose(stream: ?*c.FILE) c_int {
    var fd = readOpaqueHandle(stream);
    fd.close();
    return 0;
}

// High level file operations

export fn rename(old_filename: ?[*]const u8, new_filename: ?[*]const u8) c_int {
    if (std.os.rename(allocator, cstr.toSliceConst(old_filename.?), cstr.toSliceConst(new_filename.?))) |_| {
        return 0;
    } else |err| {
        return -1;
    }
}

// File positioning

export fn fseek(stream: ?*c.FILE, offset: c_long, origin: c_int) c_int {
    var fd = readOpaqueHandle(stream);

    switch (origin) {
        c.SEEK_SET => fd.seekTo(@intCast(usize, offset)) catch return -1,
        c.SEEK_CUR => fd.seekForward(@intCast(isize, offset)) catch return -1,
        c.SEEK_END => @panic("TODO: unimplemented SEEK_END"),
        else => @panic("fseek unreachable"),
    }

    return 0;
}

export fn ftell(stream: ?*c.FILE) c_long {
    var fd = readOpaqueHandle(stream);
    return @intCast(c_long, fd.getPos() catch return c.EOF);
}

export fn rewind(stream: ?*c.FILE) void {
    var fd = readOpaqueHandle(stream);

    // TODO: Clear EOF indicator
    fd.seekTo(0) catch @panic("rewind unreachable");
}

// NOTE: Omitted fpos_t and related functions

// Unformatted file i/o

export fn fread(noalias buffer: [*]u8, size: usize, count: usize, stream: ?*c.FILE) usize {
    var fd = readOpaqueHandle(stream);
    var b = buffer[0 .. count * size];
    return fd.read(b) catch return 0;
}

export fn fwrite(buffer: [*]const u8, size: usize, count: usize, stream: ?*c.FILE) usize {
    var fd = readOpaqueHandle(stream);
    var b = buffer[0 .. count * size];
    fd.write(b) catch return 0;
    return b.len;
}

export fn fgetc(stream: ?*c.FILE) c_int {
    var fd = readOpaqueHandle(stream);

    var b: [1]u8 = undefined;
    _ = fd.read(b[0..]) catch return c.EOF;
    return c_int(b[0]);
}

export fn getc(stream: ?*c.FILE) c_int {
    return fgetc(stream);
}

export fn getchar() c_int {
    return fgetc(@ptrCast(?*c.FILE, stdin));
}

export fn fputc(ch: c_int, stream: ?*c.FILE) c_int {
    var fd = readOpaqueHandle(stream);

    var b = []const u8{@intCast(u8, ch)};
    _ = fd.write(b[0..]) catch return c.EOF;
    return 0;
}

export fn putc(ch: c_int, stream: ?*c.FILE) c_int {
    return fputc(ch, stream);
}

export fn putchar(ch: c_int) c_int {
    return fputc(ch, @ptrCast(?*c.FILE, stdout));
}

export fn fputs(str: ?[*]const u8, stream: ?*c.FILE) c_int {
    var fd = readOpaqueHandle(stream);
    fd.write(cstr.toSliceConst(str.?)) catch return -1;
    fd.write("\n") catch return -1;
    return 0;
}

export fn puts(str: [*]const u8) c_int {
    return fputs(str, @ptrCast(?*c.FILE, stdout));
}
