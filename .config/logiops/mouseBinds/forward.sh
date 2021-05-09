#!/bin/env bash

WCLASS=$(xprop -id `xdotool getmouselocation | cut -f 5 -d :` | rg WM_CLASS)
# PID=$(xdotool getwindowfocus getwindowpid) 
# NAME=$(ps -p $PID -o comm=)

sleep 0.1
case $WCLASS in
  *"discord"*)
    xdotool key ctrl+alt+Down
    ;;
  *"flameshot"*)
    xdotool key ctrl+shift+z
    ;;
  *)
    xdotool click 9
    ;;
esac
