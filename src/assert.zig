// Corresponds to <assert.h>

// NOTE: This is defined in C as a macro, we could just write this header directly.
export fn assert(x: c_int) void {
    unreachable;
}
