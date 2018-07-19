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
    @noInlineCall(posixCallMainAndExit);
}

// TODO https://github.com/ziglang/zig/issues/265
fn posixCallMainAndExit() noreturn {
    const argc = argc_ptr[0];
    const argv = @ptrCast([*][*]u8, argc_ptr + 1);

    const envp_optional = @ptrCast([*]?[*]u8, argv + argc + 1);
    var envp_count: usize = 0;
    while (envp_optional[envp_count]) |_| : (envp_count += 1) {}
    const envp = @ptrCast([*][*]u8, envp_optional)[0..envp_count];
    if (builtin.os == builtin.Os.linux) {
        const auxv = @ptrCast([*]usize, envp.ptr + envp_count + 1);
        var i: usize = 0;
        while (auxv[i] != 0) : (i += 2) {
            if (auxv[i] < std.os.linux_aux_raw.len) std.os.linux_aux_raw[auxv[i]] = auxv[i + 1];
        }
        std.debug.assert(std.os.linux_aux_raw[std.elf.AT_PAGESZ] == std.os.page_size);
    }

    std.os.posix.exit(callMainWithArgs(argc, argv, envp));
}

fn callMainWithArgs(argc: usize, argv: [*][*]u8, envp: [][*]u8) u8 {
    std.os.ArgIteratorPosix.raw = argv[0..argc];
    std.os.posix_environ_raw = envp;
    return @intCast(u8, main());
}

// TODO: Pass through argc/argv as well
extern fn main() c_int;
