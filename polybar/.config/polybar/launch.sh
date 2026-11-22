#!/usr/bin/env sh
# Five polybar islands per connected monitor (workspaces, now playing,
# visualizer, status, battery + clock):
# compact on the laptop panel, roomy elsewhere.

killall -q polybar
while pgrep -x polybar >/dev/null; do sleep 0.1; done

for m in $(polybar --list-monitors | cut -d: -f1); do
    case "$m" in
        eDP*) bar=laptop ;;
        *)    bar=monitor ;;
    esac
    for part in left playing center status right; do
        MONITOR=$m polybar "$bar-$part" >"${XDG_RUNTIME_DIR:-/tmp}/polybar-$m-$part.log" 2>&1 &
    done
done
