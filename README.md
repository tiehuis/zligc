A libc implementation in zig.

---

To build a static libc implementation:

```
zig build
```

Header files and the `libc.a` implementation will be output to `zig-cache`.

Confirm the exported symbols with `readelf -s libc.a`.

See the `test/` directory for how to link with the generated `libc.a` vs. the
system provided version.

# Zig to C Issues

 - `uint8_t` exported via `u8` in place of `char` in many cases.
 - How can we export `#define` symbols such as `NULL` from zig.
 - Can we export untyped constants from `zig` as define symbols. E.g. see
   `float.zig`.

# Implementation Scope

Define the following headers for the implementation to limit scope for now. We
do not have complex number support or threads in zig right now so these need a
full implementation in the zig stdlib before likely proceeding.

 - `__STDC_NO_ATOMICS__` (no atomic.h implementation)
 - `__STDC_NO_THREADS__` (no threads.h implementation)
 - `__STDC_NO_COMPLEX__` (no complex.h implementation)
