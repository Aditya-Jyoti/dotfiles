#!/usr/bin/env sh
# Title of the focused window on this bar's monitor
id=$(bspc query -T -d "${MONITOR}:focused" 2>/dev/null | jq -r '.focusedNodeId // 0')

if [ -z "$id" ] || [ "$id" = "0" ]; then
    echo ""
else
    xdotool getwindowname "$id" 2>/dev/null || echo ""
fi
