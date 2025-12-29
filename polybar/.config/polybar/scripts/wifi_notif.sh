#!/bin/sh
dunstify -t 1500 -u low -r "10003" "$(iwctl station wlan0 show | grep "Connected network" | sed 's/Connected network//' | xargs | awk 'NF')"
