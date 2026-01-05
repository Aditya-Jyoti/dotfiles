#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

zscroll -l 60 \
    --delay 0.3 \
    --scroll-padding "  " \
    --match-command "$SCRIPT_DIR/get_window_title.sh --status" \
    --match-text "Home" "--scroll 0" \
    --match-text "Window" "--scroll 1" \
    --update-check true "$SCRIPT_DIR/get_window_title.sh" &

wait

