#!/usr/bin/env bash
# Tiny cava visualizer for polybar (tail = true): a thin dotted wave drawn
# with braille dots (one dot per bar, two bars per character, 4 heights).
# Shows a flat dotted line while no
# audio plays; cava's sleep_timer stops it from
# doing any work during silence. Own config — your ~/.config/cava is untouched.

CHARS=${1:-14}          # width in characters
BARS=$(( CHARS * 2 ))
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
ascii_max_range = 3
bar_delimiter = 59
frame_delimiter = 10
[smoothing]
noise_reduction = 77
CFG

# Each frame "0;3;1;…;" → braille: bar height 0..3 picks the dot row
# (bottom → top), left/right column for even/odd bars. Silence → flat line.
cava -p "$cfg" | LC_ALL=C.UTF-8 gawk -F';' -v n="$CHARS" '
BEGIN { split("64 4 2 1", L, " "); split("128 32 16 8", R, " ")  # bit per row, bottom→top
        for (i = 0; i < n; i++) flat = flat sprintf("%c", 10240 + 64 + 128) }   # ⣀⣀⣀ = silence
{
    out = ""; loud = 0
    for (i = 1; i < NF; i += 2) {
        a = $i + 0; b = (i + 1 < NF ? $(i + 1) : 0) + 0
        loud += a + b
        out = out sprintf("%c", 10240 + L[a + 1] + R[b + 1])
    }
    print (loud ? out : flat); fflush()
}'
