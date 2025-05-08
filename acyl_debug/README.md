## Introduction

Until I manage to launch (and cross-compile if needed) GDB on QNX I am stuck
with good old printf/cout debugging toolset. So, like any sane and bored
developer I created this tiny header-only library to brighten up my days, give
my eyes some rest and make it easier for me to highlight my debug-markers. ACYL
stands for "any color you like [as long as it's white]".

Fun fact: all ANSI text styles and colors are actually homogeneous Select
Graphic Rendition (SGR) parameters and can be applied in any order and amounts,
e.g. "\033[36;2;42;1m". However, this library enforces strict function
signatures in hope of improving code readability.

I know, ANSI ecape codes debuted in 1976 so we already have tons of such
libraries. Why make another one? Firstly, because it's fun. Secondly, because I
hand-picked every SGR parameter that:
1. I found useful for debug purposes,
2. is implemented in QNX Neutrino.

Q: What's with the Ghost in the Shell reference?<br>
A: People love machines in 2029 A.D.

# API

Use `acyl::colored_marker` in C++ and `acyl_colored_marker` in C as a high-level
interface functions to print some colored text on separate terminal lines.

Use `acyl::set_style` with `acyl::reset_style` in C++ and `acyl_set_style` with
`acyl_reset_style` in C to gain more fine-level control over output text style.

Some proper examples are included in comments of library header files.

# Examples

Usage in C++ (`acyl_debug.hpp`):
```C++
int main()
{
    acyl::colored_marker();

    acyl::colored_marker(acyl::Blinky, acyl::Yellow, acyl::Red, "WARNING");

    int foo = 0x1337;
    int bar = 0x7AFF;
    acyl::set_style(acyl::Bright, acyl::Cyan, acyl::Blue);
    std::cout << "foo = " << foo << ", bar = " << bar << std::endl;
    acyl::reset_style();

    return 0;
}
```

Usage in C (`acyl_debug.h`):
```C
int main()
{
    acyl_colored_marker(Normal, Cyan, Black, "...The Net is vast and infinite...");

    acyl_colored_marker(Blinky, Yellow, Red, "WARNING");

    int foo = 0x1337;
    int bar = 0x7AFF;
    acyl_set_style(Bright, Cyan, Blue);
    printf("foo = %d, bar = %d\n", foo, bar);
    acyl_reset_style();

    return 0;
}
```
