#!/usr/bin/env bash
# setting the locale, some users have issues with different locales, this forces the correct one
export LC_ALL=en_US.UTF-8

current_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

normalize_len() {
  # the max length that the percent can reach, which happens for a two digit number with a decimal house: "99.9%"
  max_len=$2
  percent_len=${#1}
  let diff_len=$max_len-$percent_len
  # if the diff_len is even, left will have 1 more space than right
  let left_spaces=($diff_len+1)/2
  let right_spaces=($diff_len)/2
  printf "%${left_spaces}s%s%${right_spaces}s\n" "" $1 ""
}

get_percent()
{
  case $(uname -s) in
    Linux)
      percent=$(LC_NUMERIC=en_US.UTF-8 top -bn2 -d 0.01 | grep "[C]pu(s)" | tail -1 | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
      normalize_len $percent 5
      ;;

    Darwin)
      cpuvalue=$(ps -A -o %cpu | awk -F. '{s+=$1} END {print s}')
      cpucores=$(sysctl -n hw.logicalcpu)
      cpuusage=$(( cpuvalue / cpucores ))
      percent="$cpuusage"
      normalize_len $percent 5
      ;;

    OpenBSD)
      cpuvalue=$(ps -A -o %cpu | awk -F. '{s+=$1} END {print s}')
      cpucores=$(sysctl -n hw.ncpuonline)
      cpuusage=$(( cpuvalue / cpucores ))
      percent="$cpuusage"
      normalize_len $percent 5
      ;;

    CYGWIN*|MINGW32*|MSYS*|MINGW*)
      # TODO - windows compatability
      ;;
  esac
}

get_load() {
  case $(uname -s) in
  Linux | Darwin | OpenBSD)
    loadavg=$(uptime | awk -F'[a-z]:' '{ print $2}' | sed 's/,//g')
    echo $loadavg
    ;;

  CYGWIN* | MINGW32* | MSYS* | MINGW*)
    # TODO - windows compatability
    ;;
  esac
}

main() {
  # storing the refresh rate in the variable RATE, default is 5
  cpu_percent=$(get_percent)
  percent=$(printf '%.0f' $cpu_percent)
  percent=$(normalize_len $percent 3)
  echo "$percent%"
}

# run main driver
main
