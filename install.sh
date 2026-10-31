#!/usr/bin/env bash
# Symlink every package into $HOME with GNU stow, then generate colours.
#   ./install.sh            stow all packages
#   ./install.sh nvim tmux  stow only these
#   ./install.sh -n         dry run

set -euo pipefail
cd "$(dirname "$(realpath "$0")")"

STOW_FLAGS=(-v -t "$HOME")
if [ "${1:-}" = -n ]; then STOW_FLAGS+=(-n); shift; fi

if [ $# -gt 0 ]; then
    pkgs=("$@")
else
    mapfile -t pkgs < <(find . -mindepth 1 -maxdepth 1 -type d ! -name '.*' -printf '%f\n' | sort)
fi

missing=()
for cmd in stow bspwm sxhkd polybar picom rofi dunst alacritty matugen feh jq; do
    command -v "$cmd" >/dev/null || missing+=("$cmd")
done
[ ${#missing[@]} -gt 0 ] && echo "warning: not installed: ${missing[*]}"

# matugen writes into these; make sure they exist as real dirs
mkdir -p "$HOME/.cache/matugen" "$HOME/.config/gtk-3.0" "$HOME/.config/gtk-4.0"

for p in "${pkgs[@]}"; do
    echo "==> $p"
    stow "${STOW_FLAGS[@]}" "$p"
done

# First run: generate colours from the last (or a default) wallpaper
if [ ! -f "$HOME/.cache/matugen/colors.sh" ] && [ -d "$HOME/.wallpapers" ]; then
    "$HOME/.config/matugen/scripts/setwall" --random || true
fi
