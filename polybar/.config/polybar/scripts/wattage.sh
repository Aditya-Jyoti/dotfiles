#!/bin/bash
# Battery power flow for polybar.
#   on battery          "8.4W"    what the laptop is drawing
#   charging            "+23.1W"  going into the battery
#   plugged in, held    "AC"      firmware charge limit reached: the laptop
#                                 runs straight off the charger, and the
#                                 battery's tiny trickle isn't worth showing
# Note: this is the battery's flow, not the charger's output — the USB-C
# controller doesn't report the latter.

BAT=/sys/class/power_supply/BAT1
AC=/sys/class/power_supply/ACAD

status=$(cat "$BAT/status" 2>/dev/null)
online=$(cat "$AC/online" 2>/dev/null)

if [ -r "$BAT/power_now" ]; then
    uw=$(cat "$BAT/power_now")
elif [ -r "$BAT/current_now" ] && [ -r "$BAT/voltage_now" ]; then
    uw=$(( $(cat "$BAT/current_now") * $(cat "$BAT/voltage_now") / 1000000 ))
else
    echo "N/A"; exit 0
fi
watts=$(awk -v u="${uw#-}" 'BEGIN { printf "%.1f", u / 1000000 }')

case $status in
    Charging)    echo "+${watts}W" ;;
    Discharging) echo "${watts}W" ;;
    *)           [ "$online" = 1 ] && echo "AC" || echo "${watts}W" ;;
esac
