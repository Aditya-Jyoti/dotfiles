#!/bin/bash
temp_raw=$(cat /sys/class/thermal/thermal_zone8/temp)
temp=$(awk "BEGIN { printf \"%.0f\", $temp_raw / 1000 }")
echo "󰍛 ${temp}°C"
