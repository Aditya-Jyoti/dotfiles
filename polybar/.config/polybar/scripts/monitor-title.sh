#!/usr/bin/env sh
# Title of the focused window on this bar's monitor.
# Event-driven (bspc subscribe) with a slow tick to catch in-window title changes.

trap 'kill 0' EXIT INT TERM

last=""
print_title() {
    id=$(bspc query -T -d "${MONITOR}:focused" 2>/dev/null | jq -r '.focusedNodeId // 0')
    if [ -z "$id" ] || [ "$id" = "0" ]; then
        title=""
    else
        title=$(xdotool getwindowname "$id" 2>/dev/null)
    fi
    [ "$title" != "$last" ] && echo "$title" && last="$title"
}

print_title
{
    bspc subscribe node_focus node_remove node_transfer desktop_focus &
    while sleep 3; do echo tick; done
} | while read -r _; do print_title; done
