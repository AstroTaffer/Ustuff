#!/bin/bash
# Display formatted PC power status

# TODO:
# var_names to VAR_NAMES with less abbreviations
# variables for colors and reset
# use knowledge of SGR parameters
# use case esac where appropriate
# use default case / else with purple coloring
# if []; then
# cycle on another line
# +++ estimated time (if charging - inf)

bat1_path="/sys/class/power_supply/BAT1"
cap=$(cat "${bat1_path}/capacity")
cap_lvl=$(cat "${bat1_path}/capacity_level")
stat=$(cat "${bat1_path}/status")
energy_full=$(cat "${bat1_path}/energy_full")
energy_now=$(cat "${bat1_path}/energy_now")
energy_flds=$(cat "${bat1_path}/energy_full_design")
cycle_count=$(cat "${bat1_path}/cycle_count")

if [ "$cap" -gt 75 ]
then
    col_cap="\e[0;92m"
elif [ "$cap" -gt 50 ]
then
    col_cap="\e[0;93m"
elif [ "$cap" -gt 25 ]
then
    col_cap="\e[0;33m"
else
    col_cap="\e[0;31m"
fi

if [ "$cap_lvl" == "Full" ]
then
    col_cap_lvl="\e[0;92m"
else
    col_cap_lvl="\e[0;35m"
fi

if [ "$stat" == "Full" ]
then
    col_stat="\e[0;92m"
elif [ "$stat" == "Discharging" ]
then
    col_stat="\e[0;93m"
else
    col_stat="\e[0;35m"
fi

health=$((100 * energy_full / energy_flds))
if [ "$health" -gt 75 ]
then
    col_health="\e[0;92m"
elif [ "$health" -gt 50 ]
then
    col_health="\e[0;93m"
elif [ "$health" -gt 25 ]
then
    col_health="\e[0;33m"
else
    col_health="\e[0;31m"
fi

echo -e "Power: ${col_cap}${cap}% (${energy_now}/${energy_full} mcAh)\e[m"
echo -e "Power level: ${col_cap_lvl}${cap_lvl}\e[m"
echo -e "Status: ${col_stat}${stat}\e[m"
echo -e "Health: ${col_health}${health}% (${energy_full}/${energy_flds} mcAh)\e[m, ${cycle_count} cycle"

exit 0

# status
#   charging
#   discharging

# power levels
#       ? full
#       normal
#       ? low

# 31 - Dark Red
# 32 - Dark Green
# 33 - Dark Yellow
# 34 - Dark Blue
# 35 - Dark Pink
# 36 - Dark Cyan
# 91 - Light Red
# 92 - Light Green
# 93 - Light Yellow
# 94 - Light Blue
# 95 - Light Pink
# 96 - Llight Cyan
