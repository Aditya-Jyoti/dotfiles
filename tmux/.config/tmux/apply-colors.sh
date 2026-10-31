#!/usr/bin/env bash
COLORS_FILE="$HOME/.cache/matugen/colors.sh"

[[ ! -f "$COLORS_FILE" ]] && exit 1

source "$COLORS_FILE"

# Strip '#' prefix
bg="${background#'#'}"
fg="${foreground#'#'}"
c0="${color0#'#'}"   # surface_dim → deepest bg
c1="${color1#'#'}"   # error → red (active window)
c3="${color3#'#'}"   # secondary → yellow-ish (status text)
c4="${color4#'#'}"   # primary → accent (active pane border, session name)
c7="${color7#'#'}"   # on_surface → bright fg
c8="${color8#'#'}"   # surface_variant → subtle borders/inactive

tmux set -g status-style                "bg=#${bg},fg=#${fg}"
tmux set -g status-left                 "#[fg=#${c4},bold] #S  "
tmux set -g status-right                "#[fg=#${c8}] %H:%M "
tmux set -g window-status-style         "fg=#${c8}"
tmux set -g window-status-current-style "fg=#${c1},bold"
tmux set -g window-status-format        " #I:#W "
tmux set -g window-status-current-format " #I:#W "
tmux set -g pane-border-style           "fg=#${c0}"
tmux set -g pane-active-border-style    "fg=#${c4}"
tmux set -g message-style               "bg=#${c8},fg=#${c7}"
tmux set -g message-command-style       "bg=#${c0},fg=#${c4}"

# Apply to all existing sessions too
tmux list-sessions -F '#S' 2>/dev/null | xargs -I{} tmux set-environment -t {} MATUGEN_APPLIED 1
