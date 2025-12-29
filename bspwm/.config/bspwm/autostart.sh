#!/usr/bin/env sh

# Start once helpers
pgrep -x sxhkd      >   /dev/null || sxhkd &
pgrep -x picom      >   /dev/null || picom -b &
pgrep -x dunst      >   /dev/null || dunst &
pgrep -x greenclip  >   /dev/null || greenclip daemon &
pgrep -x spotifyd   >   /dev/null || spotifyd &

# Polybar
"$HOME/.config/polybar/launch.sh"

# Wallpaper + theme (optional fallback)
[ -f "$HOME/.local/bin/setwall" ] && setwall ~/.wallpapers/tranquility.png
