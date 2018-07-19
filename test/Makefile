all:
	gcc -Wall -Wextra -static -nostdlib -g \
		-I../include \
		example.c \
		../lib/libc.a # must be last

clean:
	rm -f a.out

.PHONY: clean
