#!/bin/bash

for x in 0 1 5; do 
    for i in {30..37}; do 
        for a in {40..47}; do 
            echo -ne "\e[$x;$i;$a""m\\\e[$x;$i;$a""m\e[0;37;40m "
        done
        echo
    done
    echo ""
done

echo -e "\033[0;36m" "...The Net is vast and infinite..." "\033[0m"

# In QNX:
# Number  Meaning
# 0       All attributes off (except charset (10, 11, 12))
# 1       Bold
# 2       Half intensity (default to cyan on color screen)
# 4       Underline (default to red on color screen)
# 5       Blink
# 7       Reverse
# 9       Invisible
# 10      Exit alternate char set (GR & GL are restored)
# 11      Enter PC-lower char set (GR & GL are ASCII; C0 & C1 are PC_LO except for ESC)
# 12      Enter PC-higher char set (GR, C1 & GL, C0 are PC_HI except for ESC)
# 21      Normal intensity (un-Bold)
# 22      Normal intensity (un-Half intensity)
# 24      Disable underline
# 25      Disable blink
# 27      Disable reverse
# 29      Visible
# 30-37   Set foreground color (30+color_number, see below)
# 39      Set foreground to saved
# 40-47   Set background color (40+color_number, see below)
# 49      Set background to saved