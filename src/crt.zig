const builtin = @import("builtin");
const std = @import("std");

var argc_ptr: [*]usize = undefined;

export nakedcc fn _start() noreturn {
    switch (builtin.arch) {
        builtin.Arch.x86_64 => {
            argc_ptr = asm ("lea (%%rsp), %[argc]"
                : [argc] "=r" (-> [*]usize)
            );
        },
        builtin.Arch.i386 => {
            argc_ptr = asm ("lea (%%esp), %[argc]"
                : [argc] "=r" (-> [*]usize)
            );
        },
        else => @compileError("unsupported arch"),
    }

    // If LLVM inlines stack variables into _start, they will overwrite
    // the command line argument data.
    const ret = @noInlineCall(main);
    std.os.posix.exit(ret);
}

// TODO: Pass through argc/argv as well
extern fn main() c_int;
