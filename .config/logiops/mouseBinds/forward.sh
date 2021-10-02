#!/bin/env bash

WCLASS=$(xprop -id `xdotool getmouselocation | cut -f 5 -d :` | rg WM_CLASS)
# PID=$(xdotool getwindowfocus getwindowpid) 
# NAME=$(ps -p $PID -o comm=)

sleep 0.15
case $WCLASS in
  *"discord"*)
    xdotool key ctrl+alt+Down
    ;;
  *"flameshot"*)
    xdotool key ctrl+shift+z
    ;;
  *"neovide"*)
    xdotool key ctrl+i
    ;;
  *"Gimp-2.10"*)
    xdotool key ctrl+y
    ;;
  *)
    xdotool click 9
    ;;
esac
