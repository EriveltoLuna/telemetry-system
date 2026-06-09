#!/usr/bin/env bash

# GPU usage | temp | power(norm 0-100) | vram_used | vram_total

usage=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits 2>/dev/null | tr -d ' ')
temp=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits 2>/dev/null | tr -d ' ')

power_raw=$(nvidia-smi --query-gpu=power.draw --format=csv,noheader,nounits 2>/dev/null | awk '{print $1}')

read vram_used vram_total < <(
nvidia-smi --query-gpu=memory.used,memory.total --format=csv,noheader,nounits 2>/dev/null |
awk -F',' '{gsub(/ /,""); print $1, $2}'
)

# -------------------------
# FALLBACKS
# -------------------------
usage=${usage:-0}
temp=${temp:-0}
power_raw=${power_raw:-0}
vram_used=${vram_used:-0}
vram_total=${vram_total:-0}

# -------------------------
# NORMALIZA POWER (0–100)
# 170W = 100%
# -------------------------
power=$(awk "BEGIN {
  if ($power_raw > 0)
    printf \"%.0f\", ($power_raw/170)*100;
  else
    print 0
}")

echo "${usage}|${temp}|${power}|${vram_used}|${vram_total}"
