#!/usr/bin/env bash

# wifi-notify.sh — dunst notification with wifi details

IFACE=$(ip route | awk '/default/ {print $5; exit}')
[ -z "$IFACE" ] && IFACE=$(iw dev 2>/dev/null | awk '/Interface/ {print $2; exit}')

SSID=$(iw dev "$IFACE" link 2>/dev/null | awk '/SSID/ {print $2}')
IP=$(ip -4 addr show "$IFACE" 2>/dev/null | awk '/inet / {print $2}' | cut -d/ -f1)

if [ -z "$SSID" ]; then
    dunstify -u normal -i network-wireless-offline -t 4000 \
        "󰤭  WiFi" "Not connected"
    exit 0
fi

BODY="SSID: $SSID"
[ -n "$IP" ]     && BODY="$BODY\nIP: $IP"

dunstify -u normal -i network-wireless -t 5000 "󰤨  WiFi" "$BODY"
