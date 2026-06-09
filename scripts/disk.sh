#!/usr/bin/env bash

# NVME4 | NVME3 | HDD (%)

get () {
  df -P "$1" 2>/dev/null | awk 'NR==2 {gsub(/%/,""); print $5}'
}

nvme4=$(get /)
nvme3=$(get /mnt/nvme3)
hdd=$(get /mnt/hdd)

[ -z "$nvme4" ] && nvme4=0
[ -z "$nvme3" ] && nvme3=0
[ -z "$hdd" ] && hdd=0

echo "${nvme4:-0}|${nvme3:-0}|${hdd:-0}"
