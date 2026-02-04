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
        Magenta,
        Cyan,
        White
    };

    inline bool& show_output()
    {
        static bool show = false;
        return show;
    }

    inline void set_style(
        ANSI_text_styles t_st = Normal,
        ANSI_colors t_fg = White,
        ANSI_colors t_bg = Black
    )
    {
        std::cerr << "\033[" << t_st
                  << ";" << 30 + t_fg
                  << ";" << 40 + t_bg
                  << "m";
    }

    inline void reset_style()
    {
        std::cerr << "\033[0m";
    }

    inline void colored_marker(
        const char* t_msg = "ACYL marker",
        ANSI_text_styles t_st = Normal,
        ANSI_colors t_fg = White,
        ANSI_colors t_bg = Black
    )
    {
        set_style(t_st, t_fg, t_bg);
        std::cerr << t_msg;
        reset_style();
        std::cerr << '\n';
    }

    inline void colored_ok(const char* t_msg)
    {
        colored_marker(t_msg, Normal, Green);
    }

    inline void colored_error(const char* t_msg)
    {
        colored_marker(t_msg, Normal, Red);
    }
}

#endif

