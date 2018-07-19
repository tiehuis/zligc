SRCS := $(wildcard src/*.zig)

all: example

lib:
	rm -f lib/libc.a
	zig build-obj src/index.zig --name libc --output-h zig-cache/libc.h
	ar qc lib/libc.a zig-cache/libc.o zig-cache/compiler_rt.o
	ranlib lib/libc.a

example: lib
	gcc -Wall -Wextra -static -nostdlib -g \
		-fno-stack-protector \
		-Iinclude \
		example.c -o example \
		lib/libc.a # must be last

test:
	@zig test ./src/index.zig

clean:
	rm -f example lib/libc.a

.PHONY: lib example test clean
