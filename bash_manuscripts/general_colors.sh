#!/bin/bash

echo "VGA: default"
for C in {30..37}; do
    echo -en "\e[${C}m${C} "
done

echo -e "\n\nVGA: bright"
for C in {90..97}; do
    echo -en "\e[${C}m${C} "
done

echo -e "\n\n8-bit: 6x6x6"
for C in {16..231}; do
    echo -en "\e[38;5;${C}m${C} "
done

echo -e "\n\n8-bit: grayscale"
for C in {232..255}; do
    echo -en "\e[38;5;${C}m${C} "
done
