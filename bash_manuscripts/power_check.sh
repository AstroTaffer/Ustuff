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
IGPU_PATH='/sys/bus/pci/devices/0000:00:02.0/'
DGPU_PATH='/sys/bus/pci/devices/0000:01:00.0/'

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

function color_from_pci_rtm_status() {
case "$1" in
    "active")
        echo "${CGREEN}"
        ;;
    "suspended")
        echo "${CRED}"
        ;;
    *)
        echo "${CMAGENTA}"
        ;;
esac
}


# ----- GET BATTERY REPORT ----- #
BAT1_STATUS=$(cat "${BAT1_PATH}/status")
case "$BAT1_STATUS" in
    "Full")
        ;&
    "Charging")
        BAT1_STATUS_RES="${CGREEN}"
        ;;
    "Discharging")
        ;&
    "Not charging")
        BAT1_STATUS_RES="${CYELLOW}"
        ;;
    *)
        BAT1_STATUS_RES="${CMAGENTA}"
        ;;
esac
BAT1_STATUS_RES="${BAT1_STATUS_RES}${BAT1_STATUS}${CRESET}"

BAT1_CAPACITY=$(cat "${BAT1_PATH}/capacity")
BAT1_ENERGY_NOW=$(cat "${BAT1_PATH}/energy_now")
BAT1_ENERGY_FULL=$(cat "${BAT1_PATH}/energy_full")
BAT1_CAPACITY_RES="$(color_from_percentage $BAT1_CAPACITY)${BAT1_CAPACITY}%${CRESET} \
(${BAT1_ENERGY_NOW}/${BAT1_ENERGY_FULL} mcAh)"

BAT1_POWER_NOW=$(cat "${BAT1_PATH}/power_now")
if [[ $BAT1_STATUS == "Discharging" ]]; then
    BAT1_DISCHARGE_TIME=$(awk "BEGIN{print ${BAT1_ENERGY_NOW}/${BAT1_POWER_NOW}}")
    DT_HOURS=${BAT1_DISCHARGE_TIME%.*}
    DT_MINUTES=$(awk "BEGIN{print $BAT1_DISCHARGE_TIME % 1 * 60}")
    BAT1_DISCHARGE_TIME_RES="${CYELLOW}${DT_HOURS}h ${DT_MINUTES%.*}m${CRESET}"
else
    BAT1_DISCHARGE_TIME_RES="--"
fi

BAT1_ENERGY_FULL_DESIGN=$(cat "${BAT1_PATH}/energy_full_design")
CYCLE_COUNT=$(cat "${BAT1_PATH}/cycle_count")
BAT1_HEALTH=$((100 * BAT1_ENERGY_FULL / BAT1_ENERGY_FULL_DESIGN))
BAT1_HEALTH_RES="$(color_from_percentage $BAT1_HEALTH)${BAT1_HEALTH}%${CRESET} \
(${BAT1_ENERGY_FULL}/${BAT1_ENERGY_FULL_DESIGN} mcAh, \
${CYCLE_COUNT} cycle)"

BAT1_CHARGE_TYPE=$(cat "${BAT1_PATH}/charge_types")


# ----- GET ACPI REPORT ----- #
CAMERA_POWER=$(cat "${VPC_PATH}/camera_power")
CAMERA_POWER_RES="$(res_from_toggle $CAMERA_POWER)"


# ----- GET GPU REPORT ---- #
IGPU_PWR_STATE=$(cat "${IGPU_PATH}/power_state")
IGPU_RTM_STATUS=$(cat "${IGPU_PATH}/power/runtime_status")
IGPU_RES="$(color_from_pci_rtm_status $IGPU_RTM_STATUS)${IGPU_RTM_STATUS}${CRESET}"
IGPU_RES="${IGPU_PWR_STATE}\t${IGPU_RES}"

DGPU_PWR_STATE=$(cat "${DGPU_PATH}/power_state")
DGPU_RTM_STATUS=$(cat "${DGPU_PATH}/power/runtime_status")
DGPU_RES="$(color_from_pci_rtm_status $DGPU_RTM_STATUS)${DGPU_RTM_STATUS}${CRESET}"
DGPU_RES="${DGPU_PWR_STATE}\t${DGPU_RES}"

# ----- DISPLAY RESULT ----- #
echo -e "\
Status: ${BAT1_STATUS_RES}
Capacity: ${BAT1_CAPACITY_RES}
Discharge time: ${BAT1_DISCHARGE_TIME_RES}
Health: ${BAT1_HEALTH_RES}
Charge type: ${BAT1_CHARGE_TYPE}

Camera power: ${CAMERA_POWER_RES}

iGPU: ${IGPU_RES}
dGPU: ${DGPU_RES}"

exit 0


# Notes:
# fan_mode does not show changes on LOQ 15IRX9
# FAN_MODE=$(cat "${VPC_PATH}/fan_mode")
# conservation_mode attribute has been deprecated, using charge_type instead

