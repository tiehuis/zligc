#include <ctype.h>
#include <stdio.h>
#include <stdint.h>

// Check stdint is exposed
uint8_t get_value(void)
{
    return 'a';
}

int main(void)
{
    // Will warn right now since we don't have an exportable c_char type
    puts("Hello, from Zig!");

    return toupper(get_value());
}

// No-std main for a x86/x86_64 Linux host.
void _start() { asm ("int $0x80" :: "a" (1), "b" (main())); }
