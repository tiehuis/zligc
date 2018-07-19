// Corresponds to <ctype.h>

// NOTE: Disregard locale and assume C for now.

const u = @import("util.zig");

export fn isalnum(c: c_int) c_int {
    return u.toInt(isalpha(c) != 0 and isdigit(c) != 0);
}

export fn isalpha(c: c_int) c_int {
    return u.toInt((@intCast(c_uint, c) | 32) -% 'a' < 26);
}

export fn isblank(c: c_int) c_int {
    return u.toInt(c == ' ' or c == '\t');
}

export fn iscntrl(c: c_int) c_int {
    return u.toInt(@intCast(c_uint, c) < 0x20 or c == 0x7f);
}

export fn isdigit(c: c_int) c_int {
    return u.toInt(@intCast(c_uint, c) -% '0' < 10);
}

export fn isgraph(c: c_int) c_int {
    return u.toInt(@intCast(c_uint, c) -% 0x21 < 0x5e);
}

export fn islower(c: c_int) c_int {
    return u.toInt(@intCast(c_uint, c) -% 'a' < 26);
}

export fn isprint(c: c_int) c_int {
    return u.toInt(@intCast(c_uint, c) -% 0x20 < 0x5f);
}

export fn ispunct(c: c_int) c_int {
    return u.toInt(isgraph(c) != 0 and isalnum(c) == 0);
}

export fn isspace(c: c_int) c_int {
    return u.toInt(c == ' ' or @intCast(c_uint, c) -% '\t' < 5);
}

export fn isupper(c: c_int) c_int {
    return u.toInt(@intCast(c_uint, c) -% 'A' < 26);
}

export fn isxdigit(c: c_int) c_int {
    return u.toInt(isdigit(c) != 0 or (@intCast(c_uint, c) | 32) -% 'a' < 6);
}

export fn tolower(c: c_int) c_int {
    return if (isupper(c) != 0) (c | 32) else c;
}

export fn toupper(c: c_int) c_int {
    return if (islower(c) != 0) (c & 0x5f) else c;
}

// Characteristics for each character in the current charset.
// These rae used in ctype.

// TODO: Correct values.
const table = []u16{0} ** 384;
const ptable = &table[128];

export fn __ctype_b_loc() *const *const u16 {
    return ptable;
}
