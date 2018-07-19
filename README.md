A libc implementation in zig.

---

To build a static libc implementation:

```
make
```

Confirm the exported symbols with `readelf -s libc.a`.

See the `test/` directory for how to link with the generated `libc.a` vs. the
system provided version.

IMPORTANT: The provided include headers are for x86-64 linux only and are
generated from musl. If you need another (unix) platform, you can build these
using the embedded musl and replace the `./include` directory.

# License

MIT Licensed.

All C header files are copied from [musl](https://www.musl-libc.org/) which is
licensed under the MIT license.
