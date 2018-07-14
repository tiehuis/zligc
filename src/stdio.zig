// Corresponds to <stdio.h>

const std = @import("std");
const cstr = std.cstr;
const File = std.os.File;

const c = @cImport({
    @cInclude("stdio.h");
});

// File access

// TODO: Figure out how we want to define these.
export var stdin: *File = undefined;
export var stdout: *File = undefined;
export var stderr: *File = undefined;

var resolved = false;

var allocator = std.debug.global_allocator;

inline fn readOpaqueHandle(handle: ?*c.FILE) *File {
    // resolve default streams as needed, TODO: need to be thread-safe.
    if (!resolved) {
        stdin = &(std.io.getStdIn() catch @panic("could not read stdin"));
        stdout = &(std.io.getStdOut() catch @panic("could not read stdout"));
        stderr = &(std.io.getStdErr() catch @panic("could not read stderr"));
        resolved = true;
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
    // TODO: Handle stdin/stderr stream lazily
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
