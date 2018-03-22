// Corresponds to <string.h>

const std = @import("std");

//export const NULL = @import("stddef.zig").NULL;

// low-level memory functions

// Exported by builtin.zig.
//export fn memcpy(dest: ?&c_void, src: ?&const c_void, count: usize) ?&c_void {
//    unreachable;
//}

export fn memmove(dest: ?&c_void, src: ?&const c_void, count: usize) ?&c_void {
    unreachable;
}

// Exported by builtin.zig.
//export fn memset(dest: ?&c_void, ch: c_int, count: usize) ?&c_void {
//    unreachable;
//}

export fn memcmp(lhs: ?&const c_void, rhs: ?&const c_void, count: usize) c_int {
    unreachable;
}

export fn memchr(ptr: ?&c_void, ch: c_int, count: usize) ?&c_void {
    unreachable;
}

// low-level string functions

export fn strcpy(dest: ?&u8, src: ?&const u8) ?&u8 {
    unreachable;
}

export fn strncpy(dest: ?&u8, src: ?&const u8, count: usize) ?&u8 {
    unreachable;
}

export fn strcat(dest: ?&u8, src: ?&const u8) ?&u8 {
    unreachable;
}

export fn strncat(dest: ?&u8, src: ?&const u8, count: usize) ?&u8 {
    unreachable;
}

export fn strcmp(lhs: &const u8, rhs: &const u8) c_int {
    // undefined if lhs and rhs are not null-terminated strings
    return c_int(std.cstr.cmp(lhs, rhs));
}

export fn strncmp(lhs: ?&const u8, rhs: ?&const u8, count: usize) c_int {
    unreachable;
}

// NOTE: Ignored locale dependent functions

export fn strchr(str: ?&const u8, ch: c_int) ?&u8 {
    unreachable;
}

export fn strrchr(str: ?&const u8, ch: c_int) ?&u8 {
    unreachable;
}

export fn strcspn(dest: ?&const u8, src: ?&const u8) usize {
    unreachable;
}

export fn strspn(dest: ?&const u8, src: ?&const u8) usize {
    unreachable;
}

export fn strpbrk(dest: ?&const u8, breakset: ?&const u8) ?&u8 {
    unreachable;
}

export fn strstr(dest: ?&const u8, substr: ?&const u8) ?&u8 {
    unreachable;
}

export fn strtok(str: ?&u8, delim: ?&const u8) ?&u8 {
    unreachable;
}

export fn strlen(str: ?&const u8) usize {
    // null str gives a value of 0
    return if (str) |ok| std.cstr.len(ok) else 0;
}

export fn strerror(errnum: c_int) ?&u8 {
    unreachable;
}
