// Corresponds to <math.h>

const math = @import("std").math;

export fn acosf(x: f32) f32 {
    return math.acos(x);
}

export fn acos(x: f64) f64 {
    return math.acos(x);
}

export fn acoshf(x: f32) f32 {
    return math.acosh(x);
}

export fn acosh(x: f64) f64 {
    return math.acosh(x);
}

export fn asinf(x: f32) f32 {
    return math.asin(x);
}

export fn asin(x: f64) f64 {
    return math.asin(x);
}

export fn asinhf(x: f32) f32 {
    return math.asinh(x);
}

export fn asinh(x: f64) f64 {
    return math.asinh(x);
}

export fn atanf(x: f32) f32 {
    return math.atan(x);
}

export fn atan(x: f64) f64 {
    return math.atan(x);
}

export fn atan2f(x: f32, y: f32) f32 {
    return math.atan2(f32, x, y);
}

export fn atan2(x: f64, y: f64) f64 {
    return math.atan2(f64, x, y);
}

export fn atanhf(x: f32) f32 {
    return math.atanh(x);
}

export fn atanh(x: f64) f64 {
    return math.atanh(x);
}

export fn cbrtf(x: f32) f32 {
    return math.cbrt(x);
}

export fn cbrt(x: f64) f64 {
    return math.cbrt(x);
}

export fn ceilf(x: f32) f32 {
    return math.ceil(x);
}

export fn ceil(x: f64) f64 {
    return math.ceil(x);
}

export fn copysignf(x: f32, y: f32) f32 {
    return math.copysign(f32, x, y);
}

export fn copysign(x: f64, y: f64) f64 {
    return math.copysign(f64, x, y);
}

export fn cosf(x: f32) f32 {
    return math.cos(x);
}

export fn cos(x: f64) f64 {
    return math.cos(x);
}

export fn coshf(x: f32) f32 {
    return math.cosh(x);
}

export fn cosh(x: f64) f64 {
    return math.cosh(x);
}

export fn expf(x: f32) f32 {
    return math.exp(x);
}

export fn exp(x: f64) f64 {
    return math.exp(x);
}

export fn exp2f(x: f32) f32 {
    return math.exp2(x);
}

export fn exp2(x: f64) f64 {
    return math.exp2(x);
}

export fn expm1f(x: f32) f32 {
    return math.expm1(x);
}

export fn expm1(x: f64) f64 {
    return math.expm1(x);
}

export fn fabsf(x: f32) f32 {
    return math.fabs(x);
}

export fn fabs(x: f64) f64 {
    return math.fabs(x);
}

export fn floorf(x: f32) f32 {
    return math.floor(x);
}

export fn floor(x: f64) f64 {
    return math.floor(x);
}

export fn fmaf(x: f32, y: f32, z: f32) f32 {
    return math.fma(f32, x, y, z);
}

export fn fma(x: f64, y: f64, z: f64) f64 {
    return math.fma(f64, x, y, z);
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

export fn hypotf(x: f32, y: f32) f32 {
    return math.hypot(f32, x, y);
}

export fn hypot(x: f64, y: f64) f64 {
    return math.hypot(f64, x, y);
}

export fn ilogbf(x: f32) c_int {
    return math.ilogb(x);
}

export fn ilogb(x: f64) c_int {
    return math.ilogb(x);
}

export fn logf(x: f32) f32 {
    return math.ln(x);
}

export fn log(x: f64) f64 {
    return math.ln(x);
}

export fn log10f(x: f32) f32 {
    return math.log10(x);
}

export fn log10(x: f64) f64 {
    return math.log10(x);
}

export fn log1pf(x: f32) f32 {
    return math.log1p(x);
}

export fn log1p(x: f64) f64 {
    return math.log1p(x);
}

export fn log2f(x: f32) f32 {
    return math.log2(x);
}

export fn log2(x: f64) f64 {
    return math.log2(x);
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

export fn powf(base: f32, exponent: f32) f32 {
    return math.pow(f32, base, exponent);
}

export fn pow(base: f64, exponent: f64) f64 {
    return math.pow(f64, base, exponent);
}

export fn roundf(x: f32) f32 {
    return math.round(x);
}

export fn round(x: f64) f64 {
    return math.round(x);
}

export fn scalbnf(x: f32, exponent: c_int) f32 {
    return math.scalbn(x, i32(exponent));
}

export fn scalbn(x: f64, exponent: c_int) f64 {
    return math.scalbn(x, i32(exponent));
}

export fn sinf(x: f32) f32 {
    return math.sin(x);
}

export fn sin(x: f64) f64 {
    return math.sin(x);
}

export fn sinhf(x: f32) f32 {
    return math.sinh(x);
}

export fn sinh(x: f64) f64 {
    return math.sinh(x);
}

export fn sqrtf(x: f32) f32 {
    return math.sqrt(x);
}

export fn sqrt(x: f64) f64 {
    return math.sqrt(x);
}

export fn tanf(x: f32) f32 {
    return math.tan(x);
}

export fn tan(x: f64) f64 {
    return math.tan(x);
}

export fn tanhf(x: f32) f32 {
    return math.tanh(x);
}

export fn tanh(x: f64) f64 {
    return math.tanh(x);
}

export fn truncf(x: f32) f32 {
    return math.trunc(x);
}

export fn trunc(x: f64) f64 {
    return math.trunc(x);
}
