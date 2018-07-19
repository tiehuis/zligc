all: library

library:
	rm -f ./lib/libc.a
	zig build-obj ./src/index.zig --name libc --output-h ./zig-cache/libc.h
	ar qc ./lib/libc.a ./zig-cache/libc.o ./zig-cache/compiler_rt.o
	ranlib ./lib/libc.a

test:
	@zig test ./src/index.zig

clean:
	rm -f ./lib/libc.a

.PHONY: test clean
