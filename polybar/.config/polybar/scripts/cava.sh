#!/usr/bin/env bash
# Tiny cava visualizer for polybar (tail = true). Prints nothing while no
# audio plays, so the module disappears; cava's sleep_timer stops it from
# doing any work during silence. Own config — your ~/.config/cava is untouched.

BARS=${1:-10}
cfg=$(mktemp -t polybar-cava.XXXXXX)
trap 'rm -f "$cfg"; kill 0' EXIT

cat >"$cfg" <<CFG
[general]
bars = $BARS
framerate = 24
sleep_timer = 1
[input]
method = pipewire
source = auto
[output]
method = raw
raw_target = /dev/stdout
data_format = ascii
ascii_max_range = 7
bar_delimiter = 59
frame_delimiter = 10
[smoothing]
noise_reduction = 77
CFG

# "0;3;7;…;" → "▁▄█…"; an all-zero frame (silence) → empty line
cava -p "$cfg" | LC_ALL=C.UTF-8 sed -u 's/;//g; /^0*$/s/.*//; y/01234567/▁▂▃▄▅▆▇█/'
