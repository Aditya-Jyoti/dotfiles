#!/bin/bash

# see man zscroll for documentation of the following parameters
zscroll -l 40 \
    --delay 0.3 \
    --scroll-padding "  " \
    --match-command "$(dirname $0)/get_window_title.sh --status" \
    --match-text "Welcome To Reclude" "--scroll 0" \
    --update-check true "$(dirname $0)/get_window_title.sh" &

wait
