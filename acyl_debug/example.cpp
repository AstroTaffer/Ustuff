#include "acyl_debug.hpp"

int main()
{
    acyl::colored_marker("...The Net is vast and infinite...", acyl::Default, acyl::Cyan, acyl::Black);

    acyl::colored_marker("WARNING", acyl::Blinking, acyl::Yellow, acyl::Red);

    int foo = 0x1337;
    int bar = 0x7AFF;
    acyl::set_style(acyl::Default, acyl::Magenta, acyl::Blue);
    std::cout << "foo = " << foo << ", bar = " << bar << std::endl;
    acyl::reset_style();

    acyl::colored_marker("C++ API supports default arguments", acyl::Bold);

    acyl::show_output() = true;
    if (acyl::show_output())
    {
        acyl::colored_ok("C++ API has global flag for conditional output");
    }
    acyl::show_output() = false;

    return 0;
}