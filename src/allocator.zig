const std = @import("std");

// TODO: General purpose thread-safe allocator not dependent on libc
var buffer: [128]u8 = undefined;
pub var fixed = std.heap.FixedBufferAllocator.init(buffer[0..]);
