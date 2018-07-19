// We have a main entry point since we need to compile the entire set of modules
// together to avoid bundling builtin.o multiple times.

pub use @import("ctype.zig");
pub use @import("errno.zig");
pub use @import("math.zig");
pub use @import("stdio.zig");
pub use @import("stdlib.zig");
pub use @import("string.zig");
pub use @import("time.zig");
pub use @import("locale.zig");

pub use @import("crt.zig");

const builtin = @import("builtin");
const std = @import("std");

pub fn panic(msg: []const u8, error_return_trace: ?*builtin.StackTrace) noreturn {
    @setCold(true);
    while (true) {}
}
