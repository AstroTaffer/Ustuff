#!/bin/bash
# Change screen backlight brightness

BACKL_DIR="/sys/class/backlight/nvidia_wmi_ec_backlight"
MAX_BRIGHT_FD="${BACKL_DIR}/max_brightness"
MAX_BRIGHT=$(cat ${MAX_BRIGHT_FD})
BRIGHT_FD="${BACKL_DIR}/brightness"
ACT_BRIGHT=$(cat "${BACKL_DIR}/actual_brightness")

NEW_BR_VAL=$1

echo -e "Current screen brightness is \e[1;32m${ACT_BRIGHT}\e[m"

if [[ ${NEW_BR_VAL} == "" ]]; then
    exit
fi

if (( NEW_BR_VAL > MAX_BRIGHT )) || (( NEW_BR_VAL < 0 )); then
    echo -e "Incorrect screen brightness \e[1;31m${NEW_BR_VAL}\e[m, must be in \e[1;32m[0, ${MAX_BRIGHT}]\e[m"
else
    set -e
    echo ${NEW_BR_VAL} > ${BRIGHT_FD}
    echo -e "Screen brightness set to \e[1;32m${NEW_BR_VAL}\e[m"
fi

