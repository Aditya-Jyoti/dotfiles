#!/usr/bin/env bash

# bluetooth.sh — polybar bluetooth indicator

BT_POWERED=$(bluetoothctl show 2>/dev/null | awk '/Powered/ {print $2}')

if [ "$BT_POWERED" != "yes" ]; then
    echo "󰂲"  # BT off
    exit 0
fi

# Check for connected devices
CONNECTED=$(bluetoothctl devices Connected 2>/dev/null | wc -l)

if [ "$CONNECTED" -eq 0 ]; then
    echo "󰂯"  # BT on, no devices
else
    echo "󰂱"  # BT connected
fi
