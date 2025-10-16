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


static inline void acyl_set_style(enum acyl_ANSI_text_styles t_st,
                                  enum acyl_ANSI_colors t_fg,
                                  enum acyl_ANSI_colors t_bg)
{
    fprintf(stderr, "\033[%d;%d;%dm", t_st, 30 + t_fg, 40 + t_bg);
}

static inline void acyl_reset_style(void)
{
    fputs("\033[0m", stderr);
}

static inline void acyl_colored_marker(const char* t_msg,
                                       enum acyl_ANSI_text_styles t_st,
                                       enum acyl_ANSI_colors t_fg,
                                       enum acyl_ANSI_colors t_bg)
{
    acyl_set_style(t_st, t_fg, t_bg);
    fputs(t_msg, stderr);
    acyl_reset_style();
    fputc('\n', stderr);
}

static inline void acyl_colored_ok(const char* t_msg)
{
    acyl_colored_marker(t_msg, Normal, Green, Black);
}

static inline void acyl_colored_error(const char* t_msg)
{
    acyl_colored_marker(t_msg, Normal, Red, Black);
}

/*
Did you know that C doesn't support function overloading?
No acyl_colored_marker(void) for you!
No default arguments either!
*/

#endif

