#!/usr/bin/env bash
# Now playing for polybar (tail = true): whatever media is active — spotatui,
# a YouTube tab in Zen/Firefox/Brave, mpv… — via MPRIS (playerctl).
# Event-driven: playerctl --follow prints only when something changes, so this
# costs nothing while idle. playerctld tracks which player was used last.
#
# Click: play/pause · right click: next · scroll: next / previous

MAX=${1:-32}   # characters before the text is cut with …

command -v playerctl >/dev/null || { echo "󰝛 install playerctl"; sleep infinity; }
pgrep -x playerctld >/dev/null || playerctld daemon >/dev/null 2>&1

# dim colour for idle/paused = the theme's outline colour (matugen)
DIM=$(. ~/.cache/matugen/colors.sh 2>/dev/null; echo "${outline:-#888888}")

P="playerctl --player=playerctld"
wrap() { # add the click/scroll actions around the text
    printf '%%{A1:%s play-pause:}%%{A3:%s next:}%%{A4:%s next:}%%{A5:%s previous:}%s%%{A}%%{A}%%{A}%%{A}\n' \
        "$P" "$P" "$P" "$P" "$1"
}

while :; do
    $P --follow metadata --format '{{status}}|{{playerName}}|{{artist}}|{{title}}' 2>/dev/null |
    while IFS='|' read -r status player artist title; do
        if [[ -z $title ]]; then
            echo "%{F$DIM}󰝛  nothing playing%{F-}"
            continue
        fi
        case ${player,,} in
            *spotify*|*spotatui*)                       icon=󰓇 ;;
            *firefox*|*zen*|*brave*|*chrom*|*vivaldi*)
                [[ ${title,,} == *youtube* || -z $artist ]] && icon=󰗃 || icon=󰈹 ;;
            *mpv*|*vlc*)                                icon=󰐹 ;;
            *)                                          icon=󰝚 ;;
        esac
        text=${artist:+$artist · }$title
        text=${text% - YouTube}
        (( ${#text} > MAX )) && text="${text:0:MAX-1}…"
        if [[ $status == Playing ]]; then
            wrap "$icon  $text"
        else
            wrap "%{F$DIM}󰏤  $text%{F-}"
        fi
    done
    # playerctl exits when the last player goes away; show idle and wait a bit
    echo "%{F$DIM}󰝛  nothing playing%{F-}"
    sleep 2
done
