#!/usr/bin/env bash

# RAM used | total | percent

read used total < <(
free -m | awk '/Mem:/ {print $3, $2}'
)

percent=$(awk "BEGIN { if($total>0) printf \"%.0f\", ($used/$total)*100; else print 0 }")

[ -z "$used" ] && used=0
[ -z "$total" ] && total=0
[ -z "$percent" ] && percent=0

echo "${used}|${total}|${percent}"
