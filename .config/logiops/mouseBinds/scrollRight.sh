#!/bin/env bash

WCLASS=$(xprop -id `xdotool getmouselocation | cut -f 5 -d :` | rg WM_CLASS)
# PID=$(xdotool getactivewindow getwindowpid) 
# NAME=$(ps -p $PID -o comm=)

sleep 0.1
case $WCLASS in
  *"discord"*)
    xdotool key alt+Down
    ;;
  *"Firefox"*)
    xdotool key ctrl+Tab
    ;;
  *"spotify"*)
    xdotool key ctrl+Right
    ;;
  *)
    xdotool click 8
    ;;
esac
