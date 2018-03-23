#ifndef ASSERT_H
#define ASSERT_H

#ifndef NDEBUG
#   define assert(x) __builtin_unreachable
#else
#   define assert(x) ((void) 0)
#endif

#endif
