#!/usr/bin/env bash

# ---------------- CONFIG ----------------

PARENT_BAR="window-title"

# ----------------------------------------

PARENT_BAR_PID=$(pgrep -a polybar | grep "$PARENT_BAR" | awk '{print $1}')

# Get focused window title safely
window_title="$(xdotool getwindowfocus getwindowname 2>/dev/null)"

if [ -z "$window_title" ]; then
    TITLE="Welcome To Reclude"
else
    TITLE="$window_title"
fi

# -------- STATUS MODE (FOR ZSCROLL) --------
# MUST return a small, stable state string
if [ "$1" = "--status" ]; then
    if [ "$TITLE" = "Welcome To Reclude" ]; then
        echo "Home"
    else
        echo "Window"
    fi
    exit 0
fi

# -------- HOOK UPDATE FUNCTION --------

update_hooks() {
    for id in $PARENT_BAR_PID; do
        polybar-msg -p "$id" hook window-title-update "$1" >/dev/null 2>&1
    done
}

# -------- NORMAL MODE --------

if [ "$TITLE" = "Welcome To Reclude" ]; then
    update_hooks 2
else
    update_hooks 1
fi

echo "$TITLE"

