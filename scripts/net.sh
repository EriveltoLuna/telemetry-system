#!/bin/bash

RX1=$(cat /proc/net/dev | grep en | awk '{print $2}')
TX1=$(cat /proc/net/dev | grep en | awk '{print $10}')

sleep 1

RX2=$(cat /proc/net/dev | grep en | awk '{print $2}')
TX2=$(cat /proc/net/dev | grep en | awk '{print $10}')

RX=$(( (RX2 - RX1) / 1024 ))
TX=$(( (TX2 - TX1) / 1024 ))

echo "$RX,$TX"
