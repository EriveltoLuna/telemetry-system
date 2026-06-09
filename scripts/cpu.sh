#!/usr/bin/env bash

# CPU usage | temp

usage=$(LC_ALL=C top -bn1 | awk -F',' '
/Cpu/ {
  for(i=1;i<=NF;i++){
    if($i ~ /id/){
      gsub(/[^0-9.]/,"",$i)
      idle=$i
    }
  }
}
END {
  if (idle == "") print 0
  else printf "%.0f", 100 - idle
}')

temp=$(sensors 2>/dev/null | awk '
/Tctl|Package id 0/ {
  gsub(/[^0-9.]/,"",$2)
  printf "%.0f", $2
  exit
}')

[ -z "$temp" ] && temp=0

echo "${usage}|${temp}"
