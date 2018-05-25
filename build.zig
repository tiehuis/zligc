const std = @import("std");
const mem = std.mem;
const os = std.os;

const Builder = std.build.Builder;
const ArrayList = std.ArrayList;

pub fn build(b: &Builder) void {
    const mode = b.standardReleaseOptions();
    const libc = b.addCStaticLibrary("c");

    const main_object = b.addObject("libc", "src/index.zig");
    libc.addObject(main_object);

    libc.setOutputPath("./lib/libc.a");
    b.default_step.dependOn(&libc.step);
}
