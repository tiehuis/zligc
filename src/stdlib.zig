// Corresponds to <stdlib.h>

const std = @import("std");

var allocator = &@import("allocator.zig").fixed.allocator;

// Old String -> Integer

//export fn atof(str: ?*const u8) f64 {
//    unreachable;
//}

export fn atoi(str: [*]const u8) c_int {
    const buf = std.cstr.toSliceConst(str);
    return std.fmt.parseInt(c_int, buf, 10) catch 0;
}

export fn atol(str: [*]const u8) c_long {
    const buf = std.cstr.toSliceConst(str);
    return std.fmt.parseInt(c_long, buf, 10) catch 0;
}

export fn atoll(str: [*]const u8) c_longlong {
    const buf = std.cstr.toSliceConst(str);
    return std.fmt.parseInt(c_longlong, buf, 10) catch 0;
}

// C99 String -> Integer

// C99
export fn strtol(noalias str: [*]const u8, noalias str_end: ?[*]u8, base: c_int) c_long {
    // TODO: Actually set str_end
    // TODO: Set errno on failure
    const buf = std.cstr.toSliceConst(str);
    return std.fmt.parseInt(c_long, buf, @intCast(u8, base)) catch 0;
}

// C99
export fn strtoll(noalias str: [*]const u8, noalias str_end: ?[*]u8, base: c_int) c_longlong {
    // TODO: Actually set str_end
    // TODO: Set errno on failure
    const buf = std.cstr.toSliceConst(str);
    return std.fmt.parseInt(c_longlong, buf, @intCast(u8, base)) catch 0;
}

// C99
export fn strtoul(noalias str: [*]const u8, noalias str_end: ?[*]u8, base: c_int) c_ulong {
    // TODO: Actually set str_end
    // TODO: Set errno on failure
    const buf = std.cstr.toSliceConst(str);
    return std.fmt.parseUnsigned(c_ulong, buf, @intCast(u8, base)) catch 0;
}

// C99
export fn strtoull(noalias str: [*]const u8, noalias str_end: ?[*]u8, base: c_int) c_ulonglong {
    // TODO: Actually set str_end
    // TODO: Set errno on failure
    const buf = std.cstr.toSliceConst(str);
    return std.fmt.parseUnsigned(c_ulonglong, buf, @intCast(u8, base)) catch 0;
}

// String -> Float

// C99
//export fn strtof(str: ?*const u8, str_end: ?*u8) f32 {
//    unreachable;
//}

// C99
//export fn strtod(str: ?*const u8, str_end: ?*u8) f64 {
//    unreachable;
//}

// C99
//export fn strtold(str: ?*const u8, str_end: ?*u8) c_longdouble {
//    unreachable;
//}

// Random

var prng = std.rand.DefaultPrng.init(0);

export fn rand() c_int {
    return @bitCast(c_int, prng.random.scalar(c_uint));
}

export fn srand(seed: c_uint) void {
    prng.seed(seed);
}

// Memory allocation

export fn malloc(size: usize) ?*c_void {
    // TODO: Need to embed size of memory before the returned pointer
    var m = allocator.alloc(u8, size) catch return null;
    return @ptrCast(?*c_void, m.ptr);
}

export fn calloc(num: usize, size: usize) ?*c_void {
    const m = allocator.alloc(u8, size) catch return null;
    std.mem.set(u8, m, 0);
    return @ptrCast(?*c_void, m.ptr);
}

export fn realloc(ptr: ?*c_void, new_size: usize) ?*c_void {
    const old_len = 0; // (ptr - 4)[0];
    const old_mem = @ptrCast([*]u8, ptr)[0..old_len];

    var m = allocator.realloc(u8, old_mem, new_size) catch return null;
    return @ptrCast(?*c_void, m.ptr);
}

export fn free(ptr: ?*c_void) void {
    const old_len = 0; // (ptr - 4)[0];
    const old_mem = @ptrCast([*]u8, ptr)[0..old_len];
    allocator.free(old_mem);
}

// C11
export fn aligned_alloc(alignment: usize, size: usize) ?*c_void {
    // TODO: alignment parameter is comptime for zig but is not here, may need to just overallocate
    // and align manually here.
    return malloc(size);
}

// Program termination

export fn abort() noreturn {
    unreachable;
}

// TODO: extern fn requires support in get_c_type in src/codegen.cpp.
const ExitFunc = extern fn () void;

var exit_funcs = []?ExitFunc{null} ** 32;
var quick_exit_funcs = []?ExitFunc{null} ** 32;

export fn atexit() c_int { // func: ExitFunc) c_int {
    // TODO: Must be thread-safe.
    for (exit_funcs) |*mf| {
        if (mf.*) |*f| {
            //f.* = func;
            return 0;
        }
    }

    return 1;
}

export fn exit(exit_code: c_int) noreturn {
    // TODO: Must be thread-safe.
    // TODO: Call this from end of main as well to run these handlers
    var ri: usize = 0;
    while (ri < exit_funcs.len) : (ri += 1) {
        const i = exit_funcs.len - ri - 1;
        if (exit_funcs[i]) |f| {
            f();
        }
    }

    std.os.exit(@truncate(u8, @bitCast(c_uint, exit_code)));
}

// C11
export fn at_quick_exit() c_int { // func: ExitFunc) c_int {
    // TODO: Must be thread-safe.
    for (quick_exit_funcs) |*mf| {
        if (mf.*) |*f| {
            //f.* = func;
            return 0;
        }
    }

    return 1;
}

// C11
export fn quick_exit(exit_code: c_int) noreturn {
    // TODO: Must be thread-safe.
    var ri: usize = 0;
    while (ri < quick_exit_funcs.len) : (ri += 1) {
        const i = quick_exit_funcs.len - ri - 1;
        if (quick_exit_funcs[i]) |f| {
            f();
        }
    }

    std.os.exit(@truncate(u8, @bitCast(c_uint, exit_code)));
}

// Environment/Os

//export fn getenv(name: ?*const u8) ?*const u8 {
//    unreachable;
//}

// C11 - unimplemented in musl
//export fn getenv_s(len: ?*usize, value: ?*u8, valuesz: usize, name: ?*const u8) c_int {
//    unreachable;
//}

const Term = std.os.ChildProcess.Term;

export fn system(command: [*]const u8) c_int {
    // TODO: Spit command by string and perform escaping
    const argv = []const []const u8{std.cstr.toSliceConst(command)};

    var process = std.os.ChildProcess.init(argv, allocator) catch return -1;
    defer process.deinit();

    const term = process.spawnAndWait() catch return -1;
    return switch (term) {
        Term.Exited => |code| code,
        Term.Signal => |code| code,
        Term.Stopped => |code| code,
        Term.Unknown => |code| code,
    };
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
    return if (n < 0) -n else n;
}

export fn labs(n: c_int) c_long {
    return if (n < 0) -n else n;
}

// C99
export fn llabs(n: c_int) c_longlong {
    return if (n < 0) -n else n;
}

fn DivType(comptime T: type) type {
    return packed struct {
        quot: T,
        rem: T,
    };
}

export const div_t = DivType(c_int);
export fn div(x: c_int, y: c_int) div_t {
    return div_t{
        .quot = @divTrunc(x, y),
        .rem = @rem(x, y),
    };
}

export const ldiv_t = DivType(c_long);
export fn ldiv(x: c_long, y: c_long) ldiv_t {
    return ldiv_t{
        .quot = @divTrunc(x, y),
        .rem = @rem(x, y),
    };
}

// C99
export const lldiv_t = DivType(c_longlong);
export fn lldiv(x: c_longlong, y: c_longlong) lldiv_t {
    return lldiv_t{
        .quot = @divTrunc(x, y),
        .rem = @rem(x, y),
    };
}

// NOTE: Omitted multibyte functions

// NOTE: Ommitted posix/gnu extension functions

export fn getenv(name: [*]const u8) ?[*]const u8 {
    // TODO: non-posix environment
    if (std.os.getEnvPosix(std.cstr.toSliceConst(name))) |ok| {
        return ok[0..].ptr;
    } else {
        return null;
    }
}
