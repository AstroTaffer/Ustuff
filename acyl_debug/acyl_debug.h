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
    Purple,
    Cyan,
    White
};


static inline void acyl_set_style(enum acyl_ANSI_text_styles st,
                                  enum acyl_ANSI_colors fg,
                                  enum acyl_ANSI_colors bg)
{
    printf("\033[%d;%d;%dm", st, 30 + fg, 40 + bg);
}

static inline void acyl_reset_style()
{
    printf("\033[0m");
}

static inline void acyl_colored_marker(enum acyl_ANSI_text_styles st,
                                       enum acyl_ANSI_colors fg,
                                       enum acyl_ANSI_colors bg,
                                       const char* msg)
{
    acyl_set_style(st, fg, bg);
    printf("%s\n", msg);
    acyl_reset_style();
}

/*
Did you know that C doesn't support function overloads?
No acyl_colored_marker() for you!
*/

#endif

