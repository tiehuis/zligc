// Corresponds to <string.h>

const builtin = @import("builtin");
const std = @import("std");
const assert = std.debug.assert;

comptime {
    // These are implicitly defined when compiling tests.
    if (!builtin.is_test) {
        @export("memcpy", memcpy, builtin.GlobalLinkage.Strong);
        @export("memmove", memmove, builtin.GlobalLinkage.Strong);
        @export("memset", memset, builtin.GlobalLinkage.Strong);
    }
}

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

test "@memset" {
    var a = " " ** 7;
    _ = memset(a[0..].ptr, 'z', 7);
    assert(std.mem.eql(u8, a[0..7], "zzzzzzz"));
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

test "memcmp" {
    assert(memcmp(c"aaa", c"aaa", 3) == 0);
    assert(memcmp(c"aab", c"aac", 3) == -1);
    assert(memcmp(c"aac", c"aab", 3) == 1);
}

// NOTE: Return code for memchr is actually a non-const void*.
export fn memchr(ptr: [*]const u8, ch: c_int, count: usize) ?*const u8 {
    var i: usize = 0;
    while (i < count) : (i += 1) {
        if (ptr[i] == @intCast(u8, ch)) {
            return &ptr[i];
        }
    }

    return null;
}

test "memchr" {
    const p = c"aaaab";
    assert(memchr(p, 'b', 5) == &p[4]);
    assert(memchr(p, 'a', 5) == &p[0]);
    assert(memchr(p, 'c', 2) == null);
}

export fn strcpy(noalias dest: [*]u8, noalias src: [*]const u8) [*]u8 {
    var i: usize = 0;
    while (src[i] != 0) : (i += 1) {
        dest[i] = src[i];
    }
    dest[i] = 0;
    return dest;
}

test "strcpy" {
    var buffer: [8]u8 = undefined;

    _ = strcpy(buffer[0..].ptr, c"abc");
    assert(std.mem.eql(u8, buffer[0..4], "abc\x00"));
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

test "strncpy" {
    var buffer: [4]u8 = undefined;

    _ = strncpy(buffer[0..].ptr, c"abc", 4);
    assert(std.mem.eql(u8, buffer[0..4], "abc\x00"));

    _ = strncpy(buffer[0..].ptr, c"abcdef", 4);
    assert(std.mem.eql(u8, buffer[0..4], "abcd"));
}

export fn strcat(noalias dest: [*]u8, noalias src: [*]const u8) [*]u8 {
    var i: usize = 0;
    while (dest[i] != 0) : (i += 1) {}

    var j: usize = 0;
    while (src[j] != 0) : (j += 1) {
        dest[i + j] = src[j];
    }
    dest[i + j] = 0;

    return dest;
}

test "strcat" {
    var buffer: [8]u8 = undefined;
    buffer[0] = 'x';
    buffer[1] = 0;

    _ = strcat(buffer[0..].ptr, c"abc");
    assert(std.mem.eql(u8, buffer[0..5], "xabc\x00"));
}

export fn strncat(noalias dest: [*]u8, noalias src: [*]const u8, count: usize) [*]u8 {
    var i: usize = 0;
    while (dest[i] != 0) : (i += 1) {}

    var j: usize = 0;
    while (src[j] != 0 and j < count) : (j += 1) {
        dest[i + j] = src[j];
    }
    dest[i + j] = 0;

    return dest;
}

test "strncat" {
    var buffer: [8]u8 = undefined;
    buffer[0] = 'x';
    buffer[1] = 0;

    _ = strncat(buffer[0..].ptr, c"abc", 2);
    assert(std.mem.eql(u8, buffer[0..4], "xab\x00"));
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

test "strcmp" {
    assert(strcmp(c"abc", c"abc") == 0);
    assert(strcmp(c"aaa", c"cbb") == -1);
    assert(strcmp(c"cbb", c"aaa") == 1);
}

export fn strncmp(lhs: [*]const u8, rhs: [*]const u8, count: usize) c_int {
    var i: usize = 0;
    while (lhs[i] != 0 and rhs[i] != 0 and i < count) : (i += 1) {
        if (lhs[i] > rhs[i]) {
            return 1;
        } else if (lhs[i] < rhs[i]) {
            return -1;
        }
    } else {
        return 0;
    }

    if (lhs[i] == 0 and rhs[i] == 0) {
        return 0;
    } else if (rhs[i] == 0) {
        return 1;
    } else {
        return -1;
    }
}

test "strncmp" {
    assert(strncmp(c"abc", c"abc", 5) == 0);
    assert(strncmp(c"aaa", c"cbb", 3) == -1);
    assert(strncmp(c"aab", c"aaa", 2) == 0);
}

// NOTE: Actually returns a non-const ref
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

test "strchr" {
    const p = c"aaaab";
    assert(strchr(p, 'b') == &p[4]);
    assert(strchr(p, 'a') == &p[0]);
    assert(strchr(p, 'c') == null);
}

// Slow, O(n*m) version
export fn strstr(haystack: [*]const u8, needle: [*]const u8) ?*const u8 {
    const haystack_len = strlen(haystack);
    const needle_len = strlen(needle);

    if (needle_len > haystack_len) {
        return null;
    }

    var i: usize = 0;
    while (i < haystack_len - needle_len + 1) : (i += 1) {
        var j: usize = 0;
        while (j < needle_len) : (j += 1) {
            if (haystack[i + j] != needle[j]) {
                break;
            }
        } else {
            return &haystack[i];
        }
    }

    return null;
}

test "strstr" {
    const p = c"aabaacaadaaezzzaaf";
    assert(strstr(p, c"aab") == &p[0]);
    assert(strstr(p, c"aac") == &p[3]);
    assert(strstr(p, c"a") == &p[0]);
    assert(strstr(p, c"yyy") == null);
    assert(strstr(p, c"aafe") == null);
    assert(strstr(p, c"aaaaaaaaaaaaaaaaaaaaaaaaa") == null);
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

export fn strpbrk(dest: [*]const u8, breakset: [*]const u8) ?*const u8 {
    var i: usize = 0;
    while (dest[i] != 0) : (i += 1) {
        if (strchr(breakset, dest[i]) != null) {
            return &dest[i];
        }
    }

    return null;
}

test "strpbrk" {
    const p = c"abc,def ghi!";
    assert(strpbrk(p, c", !") == &p[3]);
    assert(strpbrk(p, c"! ,") == &p[3]);
    assert(strpbrk(p, c"! ") == &p[7]);
    assert(strpbrk(p, c"z") == null);
}

export fn strspn(dest: [*]const u8, accept: [*]const u8) usize {
    var i: usize = 0;

    while (dest[i] != 0) : (i += 1) {
        if (strchr(accept, dest[i]) == null) {
            break;
        }
    }

    return i;
}

test "strspn" {
    assert(strspn(c"12abcd", c"123456789") == 2);
    assert(strspn(c"12abcd", c"abcdefg") == 0);
}

export fn strcspn(dest: [*]const u8, reject: [*]const u8) usize {
    var i: usize = 0;

    while (dest[i] != 0) : (i += 1) {
        if (strchr(reject, dest[i]) != null) {
            break;
        }
    }

    return i;
}

test "strcspn" {
    assert(strcspn(c"abcd12", c"123456789") == 4);
    assert(strcspn(c"12abcd", c"abcdefg") == 2);
    assert(strcspn(c"a12abcd", c"abcdefg") == 0);
}

// TODO: depend on LC_COLLATE
export fn strcoll(lhs: [*]const u8, rhs: [*]const u8) c_int {
    return strcmp(lhs, rhs);
}
