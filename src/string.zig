// Corresponds to <string.h>

const builtin = @import("builtin");
const std = @import("std");
const assert = std.debug.assert;

inline fn copyBackward(dest: [*]u8, src: [*]const u8, count: usize) [*]u8 {
    var ri: usize = 0;
    while (ri < count) : (ri += 1) {
        const i = count - ri - 1;
        dest[i] = src[i];
    }
    return dest;
}

inline fn copyForward(dest: [*]u8, src: [*]const u8, count: usize) [*]u8 {
    var i: usize = 0;
    while (i < count) : (i += 1) {
        dest[i] = src[i];
    }
    return dest;
}

comptime {
    // These are implicitly defined when compiling tests.
    if (!builtin.is_test) {
        @export("memcpy", memcpy, builtin.GlobalLinkage.Strong);
        @export("memmove", memmove, builtin.GlobalLinkage.Strong);
        @export("memset", memset, builtin.GlobalLinkage.Strong);
    }
}

extern fn memcpy(noalias dest: [*]u8, noalias src: [*]const u8, count: usize) [*]u8 {
    return @inlineCall(copyForward, dest, src, count);
}

test "memcpy" {
    var a = " " ** 3;
    _ = memcpy(a[0..].ptr, c"abc", 3);
    assert(std.mem.eql(u8, a[0..3], "abc"));
}

extern fn memmove(dest: [*]u8, src: [*]const u8, count: usize) [*]u8 {
    const dest_p = @ptrToInt(dest);
    const src_p = @ptrToInt(src);

    if (dest_p == src_p) {
        return dest;
    }

    if (dest_p + count <= src_p or src_p + count <= dest_p) {
        return memcpy(dest, src, count);
    }

    if (dest_p < src_p) {
        return copyForward(dest, src, count);
    } else {
        return copyBackward(dest, src, count);
    }
}

test "memmove" {
    var c = "abcdefg";
    _ = memmove(c[0..].ptr, c"def", 3);
    assert(std.mem.eql(u8, c[0..7], "defdefg"));

    var a = "abcdefg";
    _ = memmove(a[0..].ptr, a[2..].ptr, 3);
    assert(std.mem.eql(u8, a[0..7], "cdedefg"));

    var b = "abcdefg";
    _ = memmove(b[2..].ptr, b[0..].ptr, 3);
    assert(std.mem.eql(u8, b[0..7], "ababcfg"));
}

extern fn memset(dest: [*]u8, ch: c_int, count: usize) [*]u8 {
    var i: usize = 0;
    while (i < count) : (i += 1) {
        dest[i] = @intCast(u8, ch);
    }
    return dest;
}

test "memset" {
    var a = " " ** 7;
    _ = memset(a[0..].ptr, 'z', 7);
    //assert(std.mem.eql(u8, a[0..7], "zzzzzzz"));
}

export fn memcmp(lhs: [*]const u8, rhs: [*]const u8, count: usize) c_int {
    var i: usize = 0;
    while (i < count) : (i += 1) {
        if (lhs[i] > rhs[i]) {
            return 1;
        } else if (lhs[i] < rhs[i]) {
            return -1;
        }
    }

    return 0;
}

export fn memchr(ptr: [*]u8, ch: c_int, count: usize) ?*u8 {
    var i: usize = 0;
    while (i < count) : (i += 1) {
        if (ptr[i] == @intCast(u8, ch)) {
            return &ptr[i];
        }
    }

    return null;
}

// low-level string functions

export fn strcpy(noalias dest: [*]u8, noalias src: [*]const u8) [*]u8 {
    var i: usize = 0;
    while (src[i] != 0) : (i += 1) {
        dest[i] = src[i];
    }
    dest[i] = 0;
    return dest;
}

export fn strncpy(noalias dest: [*]u8, noalias src: [*]const u8, count: usize) [*]u8 {
    var i: usize = 0;
    while (src[i] != 0 and i < count) : (i += 1) {
        dest[i] = src[i];
    }
    while (i < count) : (i += 1) {
        dest[i] = 0;
    }
    return dest;
}

export fn strcat(noalias dest: [*]u8, noalias src: [*]const u8) [*]u8 {
    var i: usize = 0;
    while (dest[i] != 0) : (i += 1) {}

    var j: usize = 0;
    while (src[j] != 0) : ({
        j += 1;
        i += 1;
    }) {
        dest[i + j] = src[j];
    }
    dest[i + j] = 0;

    return dest;
}

export fn strncat(noalias dest: [*]u8, noalias src: [*]const u8, count: usize) [*]u8 {
    var i: usize = 0;
    while (dest[i] != 0) : (i += 1) {}

    var j: usize = 0;
    while (src[j] != 0 and j < count) : ({
        j += 1;
        i += 1;
    }) {
        dest[i + j] = src[j];
    }
    dest[i + j] = 0;

    return dest;
}

export fn strcmp(lhs: [*]const u8, rhs: [*]const u8) c_int {
    var i: usize = 0;
    while (lhs[i] != 0 and rhs[i] != 0) : (i += 1) {
        if (lhs[i] > rhs[i]) {
            return 1;
        } else if (lhs[i] < rhs[i]) {
            return -1;
        }
    }

    if (lhs[i] == 0 and rhs[i] == 0) {
        return 0;
    } else if (rhs[i] == 0) {
        return 1;
    } else {
        return -1;
    }
}

export fn strncmp(lhs: [*]const u8, rhs: [*]const u8, count: usize) c_int {
    var i: usize = 0;
    while (lhs[i] != 0 and rhs[i] != 0 and i < count) : (i += 1) {
        if (lhs[i] > rhs[i]) {
            return 1;
        } else if (lhs[i] < rhs[i]) {
            return -1;
        }
    }

    if (lhs[i] == rhs[i]) {
        return 0;
    } else if (lhs[i] > rhs[i]) {
        return 1;
    } else {
        return -1;
    }
}

// TODO: Actually returns a non-const ref
export fn strchr(str: [*]const u8, ch: c_int) ?*const u8 {
    var i: usize = 0;
    while (str[i] != 0) : (i += 1) {
        if (str[i] == @intCast(u8, ch)) {
            return &str[i];
        }
    }

    if (ch == 0) {
        return &str[i];
    }

    return null;
}

export fn strlen(str: [*]const u8) usize {
    var i: usize = 0;
    while (str[i] != 0) : (i += 1) {}
    return i;
}

test "strlen" {
    assert(strlen(c"") == 0);
    assert(strlen(c"a") == 1);
    assert(strlen(c"abcdefgh") == 8);
}
