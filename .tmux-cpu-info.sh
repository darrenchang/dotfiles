#!/usr/bin/env bash
export LC_ALL=en_US.UTF-8

normalize() {
  local label="${1}%"
  local pad=$(( 5 - ${#label} ))
  local left=$(( (pad + 1) / 2 ))
  local right=$(( pad / 2 ))
  printf "%${left}s%s%${right}s\n" "" "$label" ""
}

case "$(uname -s)" in
  Linux)
    CACHE=/tmp/tmux-cpu-cache
    curr=$(awk '/^cpu / {print $2+$3+$4+$5+$6+$7+$8, $5}' /proc/stat)
    prev=$(cat "$CACHE" 2>/dev/null)
    echo "$curr" > "$CACHE"

    if [ -z "$prev" ]; then
      printf "  N/A  \n"; exit
    fi

    read -r total1 idle1 <<< "$prev"
    read -r total2 idle2 <<< "$curr"
    total=$(( total2 - total1 ))
    idle=$(( idle2 - idle1 ))
    [ "$total" -eq 0 ] && percent=0 || percent=$(( (total - idle) * 100 / total ))
    normalize "$percent"
    ;;

  Darwin)
    percent=$(top -l 1 -s 0 | awk '/CPU usage/ {gsub(/%/,""); print int($3+$5)}')
    normalize "$percent"
    ;;
esac
