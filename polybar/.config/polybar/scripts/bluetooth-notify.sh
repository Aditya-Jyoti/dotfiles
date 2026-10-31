#!/usr/bin/env bash

# bluetooth-notify.sh — dunst notification with BT device list

BT_POWERED=$(bluetoothctl show 2>/dev/null | awk '/Powered/ {print $2}')

if [ "$BT_POWERED" != "yes" ]; then
    dunstify -u normal -i bluetooth-disabled -t 4000 \
        "󰂲  Bluetooth" "Bluetooth is off"
    exit 0
fi

# Get connected devices
mapfile -t DEVICES < <(bluetoothctl devices Connected 2>/dev/null)

if [ "${#DEVICES[@]}" -eq 0 ]; then
    dunstify -u normal -i bluetooth -t 4000 \
        "󰂯  Bluetooth" "On — no devices connected"
    exit 0
fi

BODY=""
for dev in "${DEVICES[@]}"; do
    # line format: "Device AA:BB:CC:DD:EE:FF Device Name"
    MAC=$(echo "$dev" | awk '{print $2}')
    NAME=$(echo "$dev" | cut -d' ' -f3-)

    # Try to determine device type from bluetoothctl info
    INFO=$(bluetoothctl info "$MAC" 2>/dev/null)
    CLASS=$(echo "$INFO" | awk '/Class/ {print $2}')
    ICON_TYPE=$(echo "$INFO" | awk '/Icon/ {print $2}')

    # Map icon type to emoji/nerd font icon
    case "$ICON_TYPE" in
        audio-headset|audio-headphones) TYPE_ICON="󰋋 headphones" ;;
        input-mouse)                    TYPE_ICON="󰍽 mouse"      ;;
        input-keyboard)                 TYPE_ICON="󰌌 keyboard"   ;;
        input-gaming)                   TYPE_ICON="󰊖 controller" ;;
        phone)                          TYPE_ICON="󰄜 phone"      ;;
        audio-card|audio-speakers)      TYPE_ICON="󰓃 speaker"    ;;
        *)
            # fallback: guess from class hex
            case "${CLASS:0:4}" in
                0x02) TYPE_ICON="󰄜 phone"      ;;
                0x04) TYPE_ICON="󰋋 audio"      ;;
                0x05) TYPE_ICON="󰌌 peripheral" ;;
                *)    TYPE_ICON="󰂱 device"     ;;
            esac
            ;;
    esac

    BODY="$BODY\n$TYPE_ICON  $NAME"
done

dunstify -u normal -i bluetooth -t 6000 \
    "󰂱  Bluetooth  (${#DEVICES[@]} connected)" "$BODY"
