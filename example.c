#include <ctype.h>
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <errno.h>

extern int test_fprintf(FILE *stream, const char *fmt);

// Check stdint is exposed
uint8_t get_value(void)
{
    return 'a';
}

// TODO: Unused functions should be removed when static linking. Compile in
// a way that allows this.

int main(void)
{
    // Will warn right now since we don't have an exportable c_char type
    puts("Hello, from Zig!");

    test_fprintf(stdout, "%s, hello 0x%x %d %c %p %u %f %e\n");

    char buf[128];
    char *c;
    while ((c = fgets(buf, sizeof(buf), stdin)) != NULL) {
        fputs(buf, stdout);
    }

    /*
    //srand(0);

    //putchar(rand() % 64 + 32);
    //putchar(rand() % 64 + 32);
    //putchar(rand() % 64 + 32);

    int c;
    while ((c = getchar())) {
        putchar(c + 1);
    }

    // TODO: fflush(stdout);

    //putchar('a');
    //fputs("\nXXX\n", stderr);

    //FILE *fd = fopen("test.txt", "r");
    //fwrite("abcdefg", 4, 1, fd);
    //fclose(fd);
    //
    */

    return toupper(get_value());
}

// No-std main for a x86/x86_64 Linux host.
void _start() { asm ("int $0x80" :: "a" (1), "b" (main())); }
