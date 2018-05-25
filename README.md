A libc implementation in zig.

---

To build a static libc implementation:

```
zig build
```

Confirm the exported symbols with `readelf -s libc.a`.

See the `test/` directory for how to link with the generated `libc.a` vs. the
system provided version.

IMPORTANT: The provided include headers are for x86-64 linux only and are
generated from musl. If you need another (unix) platform, you can build these
using the embedded musl and replace the `./include` directory.

# Implementation Scope

Define the following headers for the implementation to limit scope for now. We
do not have complex number support or threads in zig right now so these need a
full implementation in the zig stdlib before likely proceeding.

 - `__STDC_NO_ATOMICS__` (no atomic.h implementation)
 - `__STDC_NO_THREADS__` (no threads.h implementation)
 - `__STDC_NO_COMPLEX__` (no complex.h implementation)

# License

MIT Licensed.

All C header files are copied from [musl](https://www.musl-libc.org/) which is
licensed under the MIT license.
