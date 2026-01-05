#!/usr/bin/env bash

read -r total used <<< $(free -m | awk '/Mem:/ {print $2, $3}')

used_gb=$(awk "BEGIN {printf \"%.1f\", $used/1024}")
total_gb=$(awk "BEGIN {printf \"%.1f\", $total/1024}")
percent=$(awk "BEGIN {printf \"%.0f\", ($used/$total)*100}")

echo " ${used_gb}G/${total_gb}G (${percent}%)"

