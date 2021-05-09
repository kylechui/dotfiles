#!/bin/env bash

WCLASS=$(xprop -id `xdotool getmouselocation | cut -f 5 -d :` | rg WM_CLASS)
# PID=$(xdotool getactivewindow getwindowpid) 
# NAME=$(ps -p $PID -o comm=)

sleep 0.1
case $WCLASS in
  *"discord"*)
    xdotool key ctrl+alt+Up
    ;;
  *"flameshot"*)
    xdotool key ctrl+z
    ;;
  *)
    xdotool click 8
    ;;
esac
