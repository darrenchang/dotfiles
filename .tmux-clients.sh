#!/bin/bash

ONLY_N=true

# Parse named arguments
while [[ "$#" -gt 0 ]]; do
    case "$1" in
        --only_n) ONLY_N="$2"; shift ;;
        --help)
            echo "Usage: $0 [--only_n <true|false>]"
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
    shift
done

# Get a map of TTYs to IPs using `who`
declare -A tty_to_ip

while read -r user tty date time ip; do
    # Normalize TTY path
    [[ "$tty" =~ ^pts/ ]] && tty="/dev/$tty"
    # Strip parentheses around IP
    ip="${ip//[\(\)]/}"
    tty_to_ip["$tty"]="$ip"
done < <(who)

# Get tmux client info: TTY and session name
mapfile -t clients < <(tmux list-clients -F "#{client_tty} #{session_name}")
TMUX_CLIENTS=0
SSH_CLIENTS=$(who | awk '{gsub(/[()]/, "", $5); if ($5 ~ /^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$/) print $5}')
N_SSH_CLIENTS=$(echo ${SSH_CLIENTS} | wc -w)

for line in "${clients[@]}"; do
  read -r tty session <<< "$line"
  ip="${tty_to_ip[$tty]}"
  ((TMUX_CLIENTS++))
  if [[ "$ONLY_N" == "false" ]]; then
    printf "Session: %-20s TTY: %-12s IP: %s\n" "$session" "$tty" "${ip:-LOCAL}"
  fi
done

if [[ "$TMUX_CLIENTS" -gt 1 || "$N_SSH_CLIENTS" -gt 1 ]]; then
  echo " (${TMUX_CLIENTS}/${N_SSH_CLIENTS})"
fi
