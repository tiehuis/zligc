// Corresponds to <math.h>

const math = @import("std").math;

// NOTE: Require macros for the type-generic functions in a header.

export fn acosf(x: f32) f32 {
    return math.acos(x);
}

export fn acos(x: f64) f64 {
    return math.acos(x);
}

export fn acosl(x: c_longdouble) c_longdouble {
    unreachable;
}

export fn acoshf(x: f32) f32 {
    return math.acosh(x);
}

export fn acosh(x: f64) f64 {
    return math.acosh(x);
}

export fn acoshl(x: c_longdouble) c_longdouble {
    unreachable;
}

export fn asinf(x: f32) f32 {
    return math.asin(x);
}

export fn asin(x: f64) f64 {
    return math.asin(x);
}

export fn asinl(x: c_longdouble) c_longdouble {
    unreachable;
}

export fn asinhf(x: f32) f32 {
    return math.asinh(x);
}

export fn asinh(x: f64) f64 {
    return math.asinh(x);
}

export fn asinhl(x: c_longdouble) c_longdouble {
    unreachable;
}

export fn atanf(x: f32) f32 {
    return math.atan(x);
}

export fn atan(x: f64) f64 {
    return math.atan(x);
}

export fn atanl(x: c_longdouble) c_longdouble {
    unreachable;
}

export fn atan2f(x: f32, y: f32) f32 {
    return math.atan2(f32, x, y);
}

export fn atan2(x: f64, y: f64) f64 {
    return math.atan2(f64, x, y);
}

export fn atan2l(x: c_longdouble, y: c_longdouble) c_longdouble {
    unreachable;
}

export fn atanhf(x: f32) f32 {
    return math.atanh(x);
}

export fn atanh(x: f64) f64 {
    return math.atanh(x);
}

export fn atanhl(x: c_longdouble) c_longdouble {
    unreachable;
}

export fn cbrtf(x: f32) f32 {
    return math.cbrt(x);
}

export fn cbrt(x: f64) f64 {
    return math.cbrt(x);
}

export fn cbrtl(x: c_longdouble) c_longdouble {
    unreachable;
}

export fn ceilf(x: f32) f32 {
    return math.ceil(x);
}

export fn ceil(x: f64) f64 {
    return math.ceil(x);
}

export fn ceill(x: c_longdouble) c_longdouble {
    unreachable;
}

export fn copysignf(x: f32, y: f32) f32 {
    return math.copysign(f32, x, y);
}

export fn copysign(x: f64, y: f64) f64 {
    return math.copysign(f64, x, y);
}

export fn copysignl(x: c_longdouble, y: c_longdouble) c_longdouble {
    unreachable;
}

export fn cosf(x: f32) f32 {
    return math.cos(x);
}

export fn cos(x: f64) f64 {
    return math.cos(x);
}

export fn cosl(x: c_longdouble) c_longdouble {
    unreachable;
}

export fn coshf(x: f32) f32 {
    return math.cosh(x);
}

export fn cosh(x: f64) f64 {
    return math.cosh(x);
}

export fn coshl(x: c_longdouble) c_longdouble {
    unreachable;
}

export fn erff(x: f32) f32 {
    unreachable;
}

export fn erf(x: f64) f64 {
    unreachable;
}

export fn erfl(x: c_longdouble) c_longdouble {
    unreachable;
}

export fn erfcf(x: f32) f32 {
    unreachable;
}

export fn erfc(x: f64) f64 {
    unreachable;
}

export fn erfcl(x: c_longdouble) c_longdouble {
    unreachable;
}

export fn expf(x: f32) f32 {
    return math.exp(x);
}

export fn exp(x: f64) f64 {
    return math.exp(x);
}

export fn expl(x: c_longdouble) c_longdouble {
    unreachable;
}

export fn exp2f(x: f32) f32 {
    return math.exp2(x);
}

export fn exp2(x: f64) f64 {
    return math.exp2(x);
}

export fn exp2l(x: c_longdouble) c_longdouble {
    unreachable;
}

export fn expm1f(x: f32) f32 {
    return math.expm1(x);
}

export fn expm1(x: f64) f64 {
    return math.expm1(x);
}

export fn expm1l(x: c_longdouble) c_longdouble {
    unreachable;
}

export fn fabsf(x: f32) f32 {
    return math.fabs(x);
}

export fn fabs(x: f64) f64 {
    return math.fabs(x);
}

export fn fabsl(x: c_longdouble) c_longdouble {
    unreachable;
}

export fn fdimf(x: f32, y: f32) f32 {
    unreachable;
}

export fn fdim(x: f64, y: f64) f64 {
    unreachable;
}

export fn fdiml(x: c_longdouble, y: c_longdouble) c_longdouble {
    unreachable;
}

export fn floorf(x: f32) f32 {
    return math.floor(x);
}

export fn floor(x: f64) f64 {
    return math.floor(x);
}

export fn floorl(x: c_longdouble) c_longdouble {
    unreachable;
}

export fn fmaf(x: f32, y: f32, z: f32) f32 {
    return math.fma(f32, x, y, z);
}

export fn fma(x: f64, y: f64, z: f64) f64 {
    return math.fma(f64, x, y, z);
}

export fn fmal(x: c_longdouble, y: c_longdouble, z: c_longdouble) c_longdouble {
    unreachable;
}

export fn fmaxf(x: f32, y: f32) f32 {
    unreachable;
}

export fn fmax(x: f64, y: f64) f64 {
    unreachable;
}

export fn fmaxl(x: c_longdouble, y: c_longdouble) c_longdouble {
    unreachable;
}

export fn fminf(x: f32, y: f32) f32 {
    unreachable;
}

export fn fmin(x: f64, y: f64) f64 {
    unreachable;
}

export fn fminl(x: c_longdouble, y: c_longdouble) c_longdouble {
    unreachable;
}

export fn fmodf(x: f32, y: f32) f32 {
    unreachable;
}

export fn fmod(x: f64, y: f64) f64 {
    unreachable;
}

export fn fmodl(x: c_longdouble, y: c_longdouble) c_longdouble {
    unreachable;
}

export fn frexpf(x: f32, exponent: *c_int) f32 {
    const r = math.frexp(x);
    exponent.* = r.exponent;
    return r.significand;
}

export fn frexp(x: f64, exponent: *c_int) f64 {
    const r = math.frexp(x);
    exponent.* = r.exponent;
    return r.significand;
}

export fn frexpl(x: c_longdouble, exponent: ?*c_int) c_longdouble {
    unreachable;
}

export fn hypotf(x: f32, y: f32) f32 {
    return math.hypot(f32, x, y);
}

export fn hypot(x: f64, y: f64) f64 {
    return math.hypot(f64, x, y);
}

export fn hypotl(x: c_longdouble, y: c_longdouble) c_longdouble {
    unreachable;
}

export fn ilogbf(x: f32) c_int {
    return math.ilogb(x);
}

export fn ilogb(x: f64) c_int {
    return math.ilogb(x);
}

export fn ilogbl(x: c_longdouble) c_int {
    unreachable;
}

export fn ldexpf(x: f32, exponent: c_int) f32 {
    unreachable;
}

export fn ldexp(x: f64, exponent: c_int) f64 {
    unreachable;
}

export fn ldexpl(x: c_longdouble, exponent: c_int) c_longdouble {
    unreachable;
}

export fn lgammaf(x: f32) f32 {
    unreachable;
}

export fn lgamma(x: f64) f64 {
    unreachable;
}

export fn lgammal(x: c_longdouble) c_longdouble {
    unreachable;
}

export fn llrintf(x: f32) c_longdouble {
    unreachable;
}

export fn llrint(x: f64) c_longdouble {
    unreachable;
}

export fn llrintl(x: c_longdouble) c_longdouble {
    unreachable;
}

export fn llroundf(x: f32) c_longdouble {
    unreachable;
}

export fn llround(x: f64) c_longdouble {
    unreachable;
}

export fn llroundl(x: c_longdouble) c_longdouble {
    unreachable;
}

export fn logf(x: f32) f32 {
    return math.ln(x);
}

export fn log(x: f64) f64 {
    return math.ln(x);
}

export fn logl(x: c_longdouble) c_longdouble {
    unreachable;
}

export fn log10f(x: f32) f32 {
    return math.log10(x);
}

export fn log10(x: f64) f64 {
    return math.log10(x);
}

export fn log10l(x: c_longdouble) c_longdouble {
    unreachable;
}

export fn log1pf(x: f32) f32 {
    return math.log1p(x);
}

export fn log1p(x: f64) f64 {
    return math.log1p(x);
}

export fn log1pl(x: c_longdouble) c_longdouble {
    unreachable;
}

export fn log2f(x: f32) f32 {
    return math.log2(x);
}

export fn log2(x: f64) f64 {
    return math.log2(x);
}

export fn log2l(x: c_longdouble) c_longdouble {
    unreachable;
}

export fn logbf(x: f32) f32 {
    unreachable;
}

export fn logb(x: f64) f64 {
    unreachable;
}

export fn logbl(x: c_longdouble) c_longdouble {
    unreachable;
}

export fn lrintf(x: f32) c_long {
    unreachable;
}

export fn lrint(x: f64) c_long {
    unreachable;
}

export fn lrintl(x: c_longdouble) c_long {
    unreachable;
}

export fn lroundf(x: f32) c_long {
    unreachable;
}

export fn lround(x: f64) c_long {
    unreachable;
}

export fn lroundl(x: c_longdouble) c_long {
    unreachable;
}

export fn modff(x: f32, iptr: *f32) f32 {
    const r = math.modf(x);
    iptr.* = r.ipart;
    return r.fpart;
}

export fn modf(x: f64, iptr: *f64) f64 {
    const r = math.modf(x);
    iptr.* = r.ipart;
    return r.fpart;
}

export fn modfl(x: c_longdouble, iptr: ?*c_longdouble) c_longdouble {
    unreachable;
}

export fn nanf(x: ?*const u8) f32 {
    unreachable;
}

export fn nan(x: ?*const u8) f64 {
    unreachable;
}

export fn nanl(x: ?*const u8) c_longdouble {
    unreachable;
}

export fn nearbyintf(x: f32) f32 {
    unreachable;
}

export fn nearbyint(x: f64) f64 {
    unreachable;
}

export fn nearbyintl(x: c_longdouble) c_longdouble {
    unreachable;
}

export fn nextafterf(from: f32, to: f32) f32 {
    unreachable;
}

export fn nextafter(from: f64, to: f64) f64 {
    unreachable;
}

export fn nextafterl(from: c_longdouble, to: c_longdouble) c_longdouble {
    unreachable;
}

export fn nexttowardf(from: f32, to: f32) f32 {
    unreachable;
}

export fn nexttoward(from: f64, to: f64) f64 {
    unreachable;
}

export fn nexttowardl(from: c_longdouble, to: c_longdouble) c_longdouble {
    unreachable;
}

export fn powf(base: f32, exponent: f32) f32 {
    return math.pow(f32, base, exponent);
}

export fn pow(base: f64, exponent: f64) f64 {
    return math.pow(f64, base, exponent);
}

export fn powl(base: c_longdouble, exponent: f64) c_longdouble {
    unreachable;
}

export fn remainderf(x: f32, y: f32) f32 {
    unreachable;
}

export fn remainder(x: f64, y: f64) f64 {
    unreachable;
}

export fn remainderl(x: c_longdouble, y: c_longdouble) c_longdouble {
    unreachable;
}

export fn remquof(x: f32, y: f32, quo: ?*c_int) f32 {
    unreachable;
}

export fn remquo(x: f64, y: f32, quo: ?*c_int) f64 {
    unreachable;
}

export fn remquol(x: c_longdouble, y: c_longdouble, quo: ?*c_int) c_longdouble {
    unreachable;
}

export fn rintf(x: f32) f32 {
    unreachable;
}

export fn rint(x: f64) f64 {
    unreachable;
}

export fn rintl(x: c_longdouble) c_longdouble {
    unreachable;
}

export fn roundf(x: f32) f32 {
    return math.round(x);
}

export fn round(x: f64) f64 {
    return math.round(x);
}

export fn roundl(x: c_longdouble) c_longdouble {
    unreachable;
}

export fn scalblnf(x: f32, exponent: c_long) f32 {
    unreachable;
}

export fn scalbln(x: f64, exponent: c_long) f64 {
    unreachable;
}

export fn scalblnl(x: c_longdouble, exponent: c_long) c_longdouble {
    unreachable;
}

export fn scalbnf(x: f32, exponent: c_int) f32 {
    return math.scalbn(x, i32(exponent));
}

export fn scalbn(x: f64, exponent: c_int) f64 {
    return math.scalbn(x, i32(exponent));
}

export fn scalbnl(x: c_longdouble, exponent: c_int) c_longdouble {
    unreachable;
}

export fn sinf(x: f32) f32 {
    return math.sin(x);
}

export fn sin(x: f64) f64 {
    return math.sin(x);
}

export fn sinl(x: c_longdouble) c_longdouble {
    unreachable;
}

export fn sinhf(x: f32) f32 {
    return math.sinh(x);
}

export fn sinh(x: f64) f64 {
    return math.sinh(x);
}

export fn sinhl(x: c_longdouble) c_longdouble {
    unreachable;
}

export fn sqrtf(x: f32) f32 {
    return math.sqrt(x);
}

export fn sqrt(x: f64) f64 {
    return math.sqrt(x);
}

export fn sqrtl(x: c_longdouble) c_longdouble {
    unreachable;
}

export fn tanf(x: f32) f32 {
    return math.tan(x);
}

export fn tan(x: f64) f64 {
    return math.tan(x);
}

export fn tanl(x: c_longdouble) c_longdouble {
    unreachable;
}

export fn tanhf(x: f32) f32 {
    return math.tanh(x);
}

export fn tanh(x: f64) f64 {
    return math.tanh(x);
}

export fn tanhl(x: c_longdouble) c_longdouble {
    unreachable;
}

export fn tgammaf(x: f32) f32 {
    unreachable;
}

export fn tgamma(x: f64) f64 {
    unreachable;
}

export fn tgammal(x: c_longdouble) c_longdouble {
    unreachable;
}

export fn truncf(x: f32) f32 {
    return math.trunc(x);
}

export fn trunc(x: f64) f64 {
    return math.trunc(x);
}

export fn truncl(x: c_longdouble) c_longdouble {
    unreachable;
}
