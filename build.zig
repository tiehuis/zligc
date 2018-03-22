const std = @import("std");

const Builder = std.build.Builder;
const ArrayList = std.ArrayList;

pub fn build(b: &Builder) void {
    const mode = b.standardReleaseOptions();
    const libc = b.addStaticLibrary("c", null);

    // Implementations which will have object files and generated headers.
    const libc_impls = [][]const u8 {
        "assert.zig",
        "ctype.zig",
        "float.zig",
        "inttypes.zig",
        "math.zig",
        "stdbool.zig",
        "stddef.zig",
        "stdint.zig",
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

        // TODO: Want to invoke ar here but we are getting a dynamic library instead?
        // See objdump -f libc.a
        libc.addObject(impl_obj);
    }

    const libc_raw_headers = [][]const u8 {
        // Copy to output folder
    };

    b.default_step.dependOn(&libc.step);
}
