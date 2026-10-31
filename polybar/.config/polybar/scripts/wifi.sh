#!/usr/bin/env bash

# wifi.sh — polybar wifi indicator
# Left-click: dunst notification with SSID + signal

IFACE=$(ip route | awk '/default/ {print $5; exit}')
# fallback: pick first wireless interface
[ -z "$IFACE" ] && IFACE=$(iw dev 2>/dev/null | awk '/Interface/ {print $2; exit}')

if [ -z "$IFACE" ] || ! iw dev "$IFACE" info &>/dev/null; then
    # Not a wireless interface or no wireless
    CONNECTED=$(ip link show "$IFACE" 2>/dev/null | grep -c "state UP" || echo 0)
    if [ "$CONNECTED" -gt 0 ]; then
        echo "󰈀"  # ethernet icon
    else
        echo "󰤭"  # no wifi
    fi
    exit 0
fi

SSID=$(iw dev "$IFACE" link 2>/dev/null | awk '/SSID/ {print $2}')
SIGNAL=$(iw dev "$IFACE" link 2>/dev/null | awk '/signal/ {print $2}')

if [ -z "$SSID" ]; then
    echo "󰤭"  # disconnected
    exit 0
fi

# Pick icon based on signal strength (dBm)
if [ -n "$SIGNAL" ]; then
    SIG_NUM=${SIGNAL//-/}  # absolute value
    if [ "$SIG_NUM" -le 50 ]; then
        ICON="󰤨"  # excellent
    elif [ "$SIG_NUM" -le 60 ]; then
        ICON="󰤥"  # good
    elif [ "$SIG_NUM" -le 70 ]; then
        ICON="󰤢"  # fair
    else
        ICON="󰤟"  # weak
    fi
else
    ICON="󰤨"
fi

echo "$ICON"
