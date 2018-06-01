// Corresponds to <stdlib.h>

// export const NULL = @import("stddef.zig").NULL;

// Old String -> Integer

export fn atof(str: ?*const u8) f64 {
    unreachable;
}

export fn atoi(str: ?*const u8) c_int {
    unreachable;
}

export fn atol(str: ?*const u8) c_long {
    unreachable;
}

export fn atoll(str: ?*const u8) c_longlong {
    unreachable;
}

// C99 String -> Integer

// C99
export fn strtoll(str: ?*const u8, str_end: ?*u8, base: c_int) c_longlong {
    unreachable;
}

// C99
export fn strtoul(str: ?*const u8, str_end: ?*u8, base: c_int) c_ulong {
    unreachable;
}

// C99
export fn strtoull(str: ?*const u8, str_end: ?*u8, base: c_int) c_ulonglong {
    unreachable;
}

// String -> Float

// C99
export fn strtof(str: ?*const u8, str_end: ?*u8) f32 {
    unreachable;
}

// C99
export fn strtod(str: ?*const u8, str_end: ?*u8) f64 {
    unreachable;
}

// C99
export fn strtold(str: ?*const u8, str_end: ?*u8) c_longdouble {
    unreachable;
}

// C99
export fn strtol(str: ?*const u8, str_end: ?*u8, base: c_int) c_long {
    unreachable;
}

// Random

export fn rand() c_int {
    unreachable;
}

export fn srand(seed: c_uint) void {
    unreachable;
}

// Memory allocation

export fn malloc(size: usize) ?*c_void {
    unreachable;
}

export fn calloc(num: usize, size: usize) ?*c_void {
    unreachable;
}

export fn realloc(ptr: ?*c_void, new_size: usize) ?*c_void {
    unreachable;
}

export fn free(ptr: ?*c_void) void {
    unreachable;
}

// C11
export fn aligned_alloc(alignment: usize, size: usize) ?*c_void {
    unreachable;
}

// Program termination

export fn abort() noreturn {
    unreachable;
}

// TODO: extern fn requires support in get_c_type in src/codegen.cpp.
//export fn atexit(func: extern fn() ?&c_void) c_int {
//    unreachable;
//}

export fn exit(exit_code: c_int) noreturn {
    unreachable;
}

// C11
//export fn at_quick_exit(func: extern fn() ?&c_void) c_int {
//    unreachable;
//}

// C11
export fn quick_exit(exit_code: c_int) noreturn {
    unreachable;
}

// Environment/Os

export fn getenv(name: ?*const u8) ?*const u8 {
    unreachable;
}

// C11 - unimplemented in musl
export fn getenv_s(len: ?*usize, value: ?*u8, valuesz: usize, name: ?*const u8) c_int {
    unreachable;
}

export fn system(command: ?*const u8) c_int {
    unreachable;
}

// Search functions

//export fn bsearch(key: ?&c_void, ptr: ?&c_void, count: usize, size: usize,
//    comp: extern fn(?&c_void, ?&c_void) c_int) ?&c_void
//{
//    unreachable;
//}

//export fn qsort(ptr: ?&c_void, count: usize, size: usize,
//    comp: extern fn(?&c_void, ?&c_void) c_int) void
//{
//    unreachable;
//}

// Math functions

export fn abs(n: c_int) c_int {
    unreachable;
}

export fn labs(n: c_int) c_long {
    unreachable;
}

// C99
export fn llabs(n: c_int) c_longlong {
    unreachable;
}

fn DivType(comptime T: type) type {
    return packed struct {
        quot: T,
        rem: T,
    };
}

export const div_t = DivType(c_int);
export fn div(x: c_int, y: c_int) div_t {
    unreachable;
}

export const ldiv_t = DivType(c_long);
export fn ldiv(x: c_long, y: c_long) ldiv_t {
    unreachable;
}

// C99
export const lldiv_t = DivType(c_longlong);
export fn lldiv(x: c_longlong, y: c_longlong) lldiv_t {
    unreachable;
}

// NOTE: Omitted multibyte functions

// TODO: Zig does not export integer/float constants via the preprocessor. Would it be valid to
// do this in all cases as opposed to explicitly typing them? We could force a symbol by typing the
// value and rely on that. A bit opaque.
export const EXIT_FAILURE = 1;
export const EXIT_SUCCESS = 1;

export const RAND_MAX = 0x7FFFFFFF;

// NOTE: Ommitted posix/gnu extension functions
