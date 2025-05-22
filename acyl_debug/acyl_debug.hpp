/*
ACYL: Any Color You Like [As Long As It's White]
A header-only library to colorize your printf() debug days

Upstream version of this library can be found at:
https://github.com/AstroTaffer/Ustuff/tree/main/acyl_debug
*/

#ifndef acyl_debug
#define acyl_debug

#include <iostream>


namespace acyl
{
    enum ANSI_text_styles
    {
        Normal,
        Bright,
        Blinky = 5
    };

    enum ANSI_colors
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


    inline void set_style(ANSI_text_styles st = Normal,
                          ANSI_colors fg = White,
                          ANSI_colors bg = Black)
    {
        std::cout << "\033[" << st
                  << ";" << 30 + fg
                  << ";" << 40 + bg
                  << "m";
    }

    inline void reset_style()
    {
        std::cout << "\033[0m";
    }

    inline void colored_marker(const char* msg = "...The Net is vast and infinite...",
                               ANSI_text_styles st = Normal,
                               ANSI_colors fg = White,
                               ANSI_colors bg = Black)
    {
        set_style(st, fg, bg);
        std::cout << msg << std::endl;
        reset_style();
    }

    inline void colored_ok(const char* msg)
    {
        colored_marker(msg, Normal, Green);
    }

    inline void colored_error(const char* msg)
    {
        colored_marker(msg, Normal, Red);
    }
}

#endif

