#include "acyl_debug.h"

int main()
{
    acyl_colored_marker("...The Net is vast and infinite...", Default, Cyan, Black);

    acyl_colored_marker("WARNING", Blinking, Yellow, Red);

    int foo = 0x1337;
    int bar = 0x7AFF;
    acyl_set_style(Default, Magenta, Blue);
    printf("foo = %d, bar = %d\n", foo, bar);
    acyl_reset_style();

    return 0;
}