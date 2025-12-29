#!/bin/bash

# The name of the polybar bar that will display the window title
PARENT_BAR="window-title"
PARENT_BAR_PID=$(pgrep -a "polybar" | grep "$PARENT_BAR" | cut -d" " -f1)

# Format of the information displayed
# If the window title is empty, it will display "Welcome To Reclude"
FORMAT="{{ window_title }}"

# Sends $2 as a message to all polybar PIDs that are part of $1
update_hooks() {
    while IFS= read -r id
    do
        polybar-msg -p "$id" hook window-title-update $2 1>/dev/null 2>&1
    done < <(echo "$1")
}

# Get the title of the currently focused window
window_title=$(xdotool getwindowfocus getwindowname)
EXIT_CODE=$?

if [ $EXIT_CODE -eq 0 ]; then
    TITLE="$window_title"
else
    TITLE="No focused window"
fi

if [ -z "$TITLE" ]; then
    TITLE="Welcome To Reclude"
fi

if [ "$1" == "--status" ]; then
    echo "$TITLE"
else
    if [ "$TITLE" = "Welcome To Reclude" ]; then
        update_hooks "$PARENT_BAR_PID" 2
        echo "$TITLE"
    else
        update_hooks "$PARENT_BAR_PID" 1
        echo "$TITLE"
    fi
fi

