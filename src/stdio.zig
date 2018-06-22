// Corresponds to <stdio.h>

const std = @import("std");
const cstr = std.cstr;
const io = std.io;
const File = std.os.File;

var allocator = std.debug.global_allocator;

export const EOF = -1;

export const SEEK_SET = 0;
export const SEEK_CUR = 1;
export const SEEK_END = 2;

export const _IOFBF = 0;
export const _IOLBF = 1;
export const _IONBF = 2;

export const BUFSIZ = 1024;
export const FILENAME_MAX = 4096;
export const FOPEN_MAX = 1000;
export const TMP_MAX = 10000;

export const FILE = @OpaqueType();

// TODO: We may want to use a tagged enum here and handle the stdout/stdin/stderr in a lazy
// fashion since we cannot constant-initialization since we may not be able to get a handle.
extern const stdin: ?*const FILE;
extern const stdout: ?*const FILE;
extern const stderr: ?*const FILE;

// File access

export fn fopen(filename: [*]const u8, mode: [*]const u8) ?*FILE {
    // TODO: Handle the mode argument
    var fd = allocator.create(File(undefined)) catch return null;
    fd.* = File.openWrite(allocator, cstr.toSliceConst(filename)) catch return null;
    return @ptrCast(?*FILE, fd);
}

export fn freopen(filename: ?*const u8, mode: ?*const u8, stream: ?*FILE) ?*FILE {
    unreachable;
}

export fn fclose(stream: ?*FILE) c_int {
    var fd = @ptrCast(*File, @alignCast(4, stream.?));
    fd.close();
    return 0;
}

// High level file operations

export fn remove(fname: ?*const u8) c_int {
    unreachable;
}

export fn rename(old_filename: ?*const u8, new_filename: ?*const u8) c_int {
    unreachable;
}

// File error handling

export fn feof(stream: ?*FILE) c_int {
    unreachable;
}

export fn ferror(stream: ?*FILE) c_int {
    unreachable;
}

export fn fflush(stream: ?*FILE) c_int {
    unreachable;
}

export fn clearerr(stream: ?*FILE) void {
    unreachable;
}

// File positioning

export fn fseek(stream: ?*FILE, offset: c_long, origin: c_int) c_int {
    unreachable;
}

export fn ftell(stream: ?*FILE) c_long {
    unreachable;
}

export fn rewind(stream: ?*FILE) void {
    unreachable;
}

// NOTE: Omitted fpos_t and related functions

// Unformatted file i/o

export fn fread(buffer: ?*c_void, size: usize, count: usize, stream: ?*FILE) usize {
    unreachable;
}

export fn fwrite(buffer: ?*const c_void, size: usize, count: usize, stream: ?*FILE) usize {
    unreachable;
}

export fn fgetc(stream: ?*FILE) c_int {
    unreachable;
}

export fn getc(stream: ?*FILE) c_int {
    return fgetc(stream);
}

export fn getchar() c_int {
    unreachable;
}

export fn ungetc(ch: c_int, stream: ?*FILE) c_int {
    unreachable;
}

export fn fputc(ch: c_int, stream: ?*FILE) c_int {
    unreachable;
}

export fn putc(ch: c_int, stream: ?*FILE) c_int {
    return fputc(ch, stream);
}

export fn putchar(ch: c_int) c_int {
    unreachable;
}

export fn fputs(str: ?*const u8, stream: ?*FILE) c_int {
    unreachable;
}

export fn puts(str: [*]const u8) c_int {
    var stdout_file = io.getStdOut() catch return -1;
    stdout_file.write(cstr.toSliceConst(str)) catch return -1;
    stdout_file.write("\n") catch return -1;
    return 0;
}

// NOTE: Omitted variadic printf functions for now. How does zig deal with these?

export fn perror(s: [*]const u8) void {
    unreachable;
}

// Buffer handling

export fn setvbuf(stream: ?*FILE, buffer: ?*u8, mode: c_int, size: usize) c_int {
    unreachable;
}

export fn setbuf(stream: ?*FILE, buffer: ?*u8) void {
    unreachable;
}

// Temporary file handling

export fn tmpnam(filename: ?*u8) ?*u8 {
    unreachable;
}

export fn tmpfile() ?*FILE {
    unreachable;
}
