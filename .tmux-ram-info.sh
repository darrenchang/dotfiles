#!/usr/bin/env bash
export LC_ALL=en_US.UTF-8

case "$(uname -s)" in
  Linux)
    usage="$(free -h | awk 'NR==2 {print $3}')"
    total="$(free -h | awk 'NR==2 {print $2}')"
    ratio="${usage}/${total}"
    echo "${ratio//i/B}"
    ;;

  Darwin)
    pagesize=$(pagesize)
    total_pages=$(( $(sysctl -n hw.memsize) / pagesize ))
    free_pages=$(vm_stat | awk '/^Pages free:|^Pages speculative:/ {gsub(/\./,""); sum+=$NF} END {print sum}')
    used_pages=$(( total_pages - free_pages ))
    used_mb=$(( used_pages * pagesize / 1048576 ))
    total_mb=$(( $(sysctl -n hw.memsize) / 1048576 ))

    if (( used_mb < 1024 )); then
      echo "${used_mb}MB/${total_mb}MB"
    else
      echo "$(( used_mb / 1024 ))GB/$(( total_mb / 1024 ))GB"
    fi
    ;;
esac
