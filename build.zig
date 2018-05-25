const std = @import("std");
const mem = std.mem;
const os = std.os;

const Builder = std.build.Builder;
const ArrayList = std.ArrayList;

pub fn build(b: &Builder) void {
    const mode = b.standardReleaseOptions();
    const libc = b.addCStaticLibrary("c");

    const libc_impls = [][]const u8 {
        "ctype.zig",
        "math.zig",
        "stdio.zig",
        "stdlib.zig",
        "string.zig",
    };

    inline for (libc_impls) |impl| {
        // We want to share the base required details from zig for each intermediate object file
        // here. This is why the libc.a file is so large, because the zig runtime/builtin details
        // are embedded in each object. This is mentioned on the main issue.

        const impl_obj = b.addObject(impl, "src/" ++ impl);

        // Determine the appropriate output folder here. Note that the builder does not currently
        // have a default output folder configured so there will likely be some extra implementation
        // required in std/build.zig.
        libc.addObject(impl_obj);
    }

    b.default_step.dependOn(&libc.step);
}
