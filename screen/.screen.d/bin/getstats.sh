#!/bin/bash
# Quick system checks to be used by screen.
# Author Tony G. <tonyskapunk@tonyskapunk.net>

while getopts "mlsSu" o
do
  case "$o" in
    m) free -m|grep Mem|awk '{print $4}';;
    l) uptime|cut -d: -f5;;
    s) free -m|grep Swap|awk '{print $4}';;
    S) screen -ls | grep $PPID | awk '{print $1}' | cut -f2 -d.;;
    u) uptime|cut -d, -f1 
  esac
done

