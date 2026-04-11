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
    used_pages=$(vm_stat | awk '/active|wired|compressor|speculative/ {gsub(/\./,""); sum+=$NF} END {print sum}')
    used_mb=$(( used_pages * pagesize / 1048576 ))
    total_mb=$(( $(sysctl -n hw.memsize) / 1048576 ))

    if (( used_mb < 1024 )); then
      echo "${used_mb}MB/${total_mb}MB"
    else
      echo "$(( used_mb / 1024 ))GB/$(( total_mb / 1024 ))GB"
    fi
    ;;
esac
