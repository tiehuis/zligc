const std = @import("std");

const c = @cImport({
    @cInclude("locale.h");
});

// NOTE: Actual declaration returns non-const
export fn setlocale(category: c_int, locale: ?[*]const u8) ?[*]const u8 {
    return c"C";
}

var buffer: [2]u8 = undefined;

var posix_lconv = c.struct_lconv{
    .decimal_point = undefined,
    .thousands_sep = undefined,
    .grouping = undefined,
    .int_curr_symbol = undefined,
    .currency_symbol = undefined,
    .mon_decimal_point = undefined,
    .mon_thousands_sep = undefined,
    .mon_grouping = undefined,
    .positive_sign = undefined,
    .negative_sign = undefined,
    .int_frac_digits = @maxValue(u8),
    .frac_digits = @maxValue(u8),
    .p_cs_precedes = @maxValue(u8),
    .p_sep_by_space = @maxValue(u8),
    .n_cs_precedes = @maxValue(u8),
    .n_sep_by_space = @maxValue(u8),
    .p_sign_posn = @maxValue(u8),
    .n_sign_posn = @maxValue(u8),
    .int_p_cs_precedes = @maxValue(u8),
    .int_p_sep_by_space = @maxValue(u8),
    .int_n_cs_precedes = @maxValue(u8),
    .int_n_sep_by_space = @maxValue(u8),
    .int_p_sign_posn = @maxValue(u8),
    .int_n_sign_posn = @maxValue(u8),
};

export fn localeconv() *c.struct_lconv {
    // workaround for requiring non-const string
    buffer[0] = '.';
    buffer[1] = 0;
    var DOT = @ptrCast([*]u8, &buffer[0]);
    var EMPTY = @ptrCast([*]u8, &buffer[1]);

    posix_lconv.decimal_point = DOT;
    posix_lconv.thousands_sep = EMPTY;
    posix_lconv.grouping = EMPTY;
    posix_lconv.int_curr_symbol = EMPTY;
    posix_lconv.mon_decimal_point = EMPTY;
    posix_lconv.mon_thousands_sep = EMPTY;
    posix_lconv.mon_grouping = EMPTY;
    posix_lconv.positive_sign = EMPTY;
    posix_lconv.negative_sign = EMPTY;

    return &posix_lconv;
}
