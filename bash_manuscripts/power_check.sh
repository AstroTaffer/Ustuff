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

function color_by_value() {
if (($1 > 66)); then
    echo "${CGREEN}"
elif (($1 > 33)); then
    echo "${CYELLOW}"
else
    echo "${CRED}"
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
CAPACITY_RES="$(color_by_value $CAPACITY)${CAPACITY}%${CRESET} \
(${ENERGY_NOW}/${ENERGY_FULL} mcAh)"

ENERGY_FULL_DESIGN=$(cat "${BAT1_PATH}/energy_full_design")
CYCLE_COUNT=$(cat "${BAT1_PATH}/cycle_count")
HEALTH=$((100 * ENERGY_FULL / ENERGY_FULL_DESIGN))
HEALTH_RES="$(color_by_value $HEALTH)${HEALTH}%${CRESET} \
(${ENERGY_FULL}/${ENERGY_FULL_DESIGN} mcAh, \
${CYCLE_COUNT} cycle)"


# ----- GET ACPI REPORT ----- #
CONS_MODE=$(cat "${VPC_PATH}/conservation_mode")
if [[ ${CONS_MODE} == 1 ]]; then
    CONS_MODE_RES="${CGREEN}ON"
else
    CONS_MODE_RES="${CRED}OFF"
fi
CONS_MODE_RES="${CONS_MODE_RES}${CRESET}"

CAMERA_POWER=$(cat "${VPC_PATH}/camera_power")
if [[ ${CAMERA_POWER} == 1 ]]; then
    CAMERA_POWER_RES="${CGREEN}ON"
else
    CAMERA_POWER_RES="${CRED}OFF"
fi
CAMERA_POWER_RES="${CAMERA_POWER_RES}${CRESET}"


# ----- DISPLAY RESULT ----- #
echo -e "\
Status: ${STATUS_RES}
Capacity: ${CAPACITY_RES}
Health: ${HEALTH_RES}

Conservation mode: ${CONS_MODE_RES}
Camera power: ${CAMERA_POWER_RES}
"

exit 0


# TODO:
# +++ estimated time (if charging - inf)
# fan mode

