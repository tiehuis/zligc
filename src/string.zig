// Corresponds to <string.h>

const std = @import("std");

export fn memcpy(noalias dest: [*]u8, noalias src: [*]const u8, count: usize) [*]u8 {
    var i: usize = 0;
    while (i < count) : (i += 1) {
        dest[i] = src[i];
    }
    return dest;
}

export fn memmove(dest: [*]u8, src: [*]const u8, count: usize) [*]u8 {
    // TODO: Should handle overlap.
    var i: usize = 0;
    while (i < count) : (i += 1) {
        dest[i] = src[i];
    }
    return dest;
}

export fn memset(dest: [*]u8, ch: c_int, count: usize) [*]u8 {
    var i: usize = 0;
    while (i < count) : (i += 1) {
        dest[i] = @intCast(u8, ch);
    }
    return dest;
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
