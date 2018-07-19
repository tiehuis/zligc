const std = @import("std");

const c = @cImport({
    @cInclude("time.h");
});

export fn time(maybe_t: ?*c.time_t) c.time_t {
    var s = @intCast(c.time_t, std.os.time.timestamp());

    if (maybe_t) |t| {
        t.* = s;
    }

    return s;
}

export fn clock() c.clock_t {
    var timer = std.os.time.Timer.start() catch return -1;
    const ratio = std.os.time.ns_per_s / c.CLOCKS_PER_SEC;
    return @divTrunc(@intCast(c_long, timer.read()), ratio);
}

var gmtime_return: c.struct_tm = undefined;

export fn gmtime(timep: *const c.time_t) *c.struct_tm {
    // TODO: actually compute this for real
    gmtime_return = c.struct_tm{
        .tm_sec = 0,
        .tm_min = 0,
        .tm_hour = 0,
        .tm_mday = 1,
        .tm_mon = 0,
        .tm_year = 0,
        .tm_wday = 1,
        .tm_yday = 1,
        .tm_isdst = 0,

        .tm_gmtoff = 0,
        .tm_zone = null,
    };

    return &gmtime_return;
}

export fn localtime(timep: *const c.time_t) *c.struct_tm {
    // TODO: Get local timezone and don't assume UTC
    return gmtime(timep);
}

export fn strftime(s: [*]u8, max: usize, fmt: [*]const u8, tm: *c.struct_tm) usize {
    // TODO: Parse format string
    s[0] = 0;
    return 0;
}

export fn mktime(tm: *c.struct_tm) c.time_t {
    // TODO: parse tm into epoch
    return 0;
}

export fn difftime(time1: c.time_t, time0: c.time_t) f64 {
    return @intToFloat(f64, time1 - time0);
}
