## Introduction

I created this library when I was struggling with using GDB on QNX. Although
I managed to tame that beast, I still enjoy me some good old printf/cout
debugging. It's simple and unobstructive, i.e. it doesn't make time-dependent
hardware go nuts. So I keep this tiny header-only library to brighten up
my days, give my eyes some rest and make it easier for me to highlight my
debug-markers.

Fun fact: all ANSI text styles and colors are actually homogeneous Select
Graphic Rendition (SGR) parameters and can be applied in any order and amounts,
e.g. `\033[36;2;42;1m`. However, this library enforces strict function
signatures in hope of improving code readability.

I know, ANSI ecape codes debuted in 1976 so we already have tons of such
libraries. Why make another one? Firstly, because it's fun. Secondly, because I
hand-picked every SGR parameter that:
1. I found useful for debug purposes;
2. is implemented in terminals I use.

ACYL stands for "Any Color You Like [As Long As It's White]".

Upstream version of this library can be found at: 
https://github.com/AstroTaffer/Ustuff/tree/main/acyl_debug

Q: What's with the Ghost in the Shell reference?<br>
A: People love machines in 2029 A.D.

# API

Use `acyl::colored_*` in C++ and `acyl_colored_*` in C as a high-level
interface to print some colored text on separate terminal lines.

Use `acyl::set_style` with `acyl::reset_style` in C++ and `acyl_set_style` with
`acyl_reset_style` in C to gain more fine-level control over output text style.

In C++ there is a `acyl::show_output` function to get and set global flag which
you may (manually) check to output text conditionally. Usefull if you need to
see output only once per second, for example.

# Examples

See `example.cpp` and `example.c` for usage examples in C++ and C respectively.
Build them with `make clean all` for a quick test.
