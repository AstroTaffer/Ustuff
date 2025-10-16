/*
ACYL: Any Color You Like [As Long As It's White]
A header-only library to colorize your printf() debug days

Upstream version of this library can be found at:
https://github.com/AstroTaffer/Ustuff/tree/main/acyl_debug
*/

#ifndef acyl_debug
#define acyl_debug

#include <stdio.h>


enum acyl_ANSI_text_styles
{
    Normal,
    Bright,
    Blinky = 5
};

enum acyl_ANSI_colors
{
    Black,
    Red,
    Green,
    Yellow,
    Blue,
    Magenta,
    Cyan,
    White
};


static inline void acyl_set_style(enum acyl_ANSI_text_styles st,
                                  enum acyl_ANSI_colors fg,
                                  enum acyl_ANSI_colors bg)
{
    fprintf(stderr, "\033[%d;%d;%dm", st, 30 + fg, 40 + bg);
}

static inline void acyl_reset_style()
{
    fputs("\033[0m", stderr);
}

static inline void acyl_colored_marker(const char* msg,
                                       enum acyl_ANSI_text_styles st,
                                       enum acyl_ANSI_colors fg,
                                       enum acyl_ANSI_colors bg)
{
    acyl_set_style(st, fg, bg);
    fputs(msg, stderr);
    acyl_reset_style();
    fputc('\n', stderr);
}

static inline void acyl_colored_ok(const char* msg)
{
    acyl_colored_marker(msg, Normal, Green, Black);
}

static inline void acyl_colored_error(const char* msg)
{
    acyl_colored_marker(msg, Normal, Red, Black);
}

/*
Did you know that C doesn't support function overloads?
No acyl_colored_marker() for you!
No default arguments either!
*/

#endif

