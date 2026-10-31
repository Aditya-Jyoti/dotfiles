#!/bin/bash
# Reads live power draw in watts from sysfs
# Falls back to power_now if available (some hardware reports it directly)

BAT_PATH="/sys/class/power_supply/BAT1"

if [ -f "$BAT_PATH/power_now" ]; then
    power_uw=$(cat "$BAT_PATH/power_now")
    watts=$(awk "BEGIN { printf \"%.1f\", $power_uw / 1000000 }")
elif [ -f "$BAT_PATH/current_now" ] && [ -f "$BAT_PATH/voltage_now" ]; then
    current_ua=$(cat "$BAT_PATH/current_now")
    voltage_uv=$(cat "$BAT_PATH/voltage_now")
    watts=$(awk "BEGIN { printf \"%.1f\", ($current_ua * $voltage_uv) / 1000000000000 }")
else
    echo "N/A"
    exit 0
fi

echo "󱐋 ${watts}W"
