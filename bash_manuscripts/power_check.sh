#!/bin/bash
# Display formatted PC power status


# ----- INIT ----- #
CRESET='\e[m'
CRED='\e[91m'
CGREEN='\e[92m'
CYELLOW='\e[93m'
CMAGENTA='\e[95m'

BAT1_PATH='/sys/class/power_supply/BAT1'
VPC_PATH='/sys/bus/platform/drivers/ideapad_acpi/VPC2004:00'

function color_from_percentage() {
    if (($1 > 66)); then
        echo "${CGREEN}"
    elif (($1 > 33)); then
        echo "${CYELLOW}"
    else
        echo "${CRED}"
    fi
}

function res_from_toggle() {
    if [[ $1 == 1 ]]; then
        echo "${CGREEN}ON${CRESET}"
    elif [[ $1 == 0 ]]; then
        echo "${CRED}OFF${CRESET}"
    else
        echo "${CMAGENTA}ERR${CRESET}"
    fi
}


# ----- GET BATTERY REPORT ----- #
STATUS=$(cat "${BAT1_PATH}/status")
case "$STATUS" in
    "Full")
        ;&
    "Charging")
        STATUS_RES="${CGREEN}"
        ;;
    "Discharging")
        ;&
    "Not charging")
        STATUS_RES="${CYELLOW}"
        ;;
    *)
        STATUS_RES="${CMAGENTA}"
        ;;
esac
STATUS_RES="${STATUS_RES}${STATUS}${CRESET}"

CAPACITY=$(cat "${BAT1_PATH}/capacity")
ENERGY_NOW=$(cat "${BAT1_PATH}/energy_now")
ENERGY_FULL=$(cat "${BAT1_PATH}/energy_full")
CAPACITY_RES="$(color_from_percentage $CAPACITY)${CAPACITY}%${CRESET} \
(${ENERGY_NOW}/${ENERGY_FULL} mcAh)"

ENERGY_FULL_DESIGN=$(cat "${BAT1_PATH}/energy_full_design")
CYCLE_COUNT=$(cat "${BAT1_PATH}/cycle_count")
HEALTH=$((100 * ENERGY_FULL / ENERGY_FULL_DESIGN))
HEALTH_RES="$(color_from_percentage $HEALTH)${HEALTH}%${CRESET} \
(${ENERGY_FULL}/${ENERGY_FULL_DESIGN} mcAh, \
${CYCLE_COUNT} cycle)"


# ----- GET ACPI REPORT ----- #
CONS_MODE=$(cat "${VPC_PATH}/conservation_mode")
CONS_MODE_RES="$(res_from_toggle $CONS_MODE)"

CAMERA_POWER=$(cat "${VPC_PATH}/camera_power")
CAMERA_POWER_RES="$(res_from_toggle $CAMERA_POWER)"

FAN_MODE=$(cat "${VPC_PATH}/fan_mode")

# ----- DISPLAY RESULT ----- #
echo -e "\
Status: ${STATUS_RES}
Capacity: ${CAPACITY_RES}
Health: ${HEALTH_RES}

Conservation mode: ${CONS_MODE_RES}
Camera power: ${CAMERA_POWER_RES}
Fan mode: ${FAN_MODE}
"

exit 0

# "Fan mode" does not show changes on LOQ 15IRX9

# TODO:
# +++ estimated time (if charging - inf)

