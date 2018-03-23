#include <ctype.h>

int main(void)
{
    return toupper('a');
}

// No-std main for a x86/x86_64 Linux host.
void _start() { asm ("int $0x80" :: "a" (1), "b" (main())); }
