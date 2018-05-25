all:
	clang -Wall -Wextra -static -nostdlib \
		-I../include \
		example.c \
		../lib/libc.a # must be last

clean:
	rm -f a.out

.PHONY: clean
