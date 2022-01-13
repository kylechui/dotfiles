#!/bin/bash
NUM_MONITORS=$(xrandr -q | grep " connected " | wc -l)
if [ $NUM_MONITORS -eq 1 ]; then
  ~/.screenlayout/SingleMonitor.sh
else
  ~/.screenlayout/BigMonitor.sh
fi
# if [ $NUM_MONITORS = 1 ]; then
#   ~/.screenlayout/MultipleMonitors.sh
# else
#   ~/.screenlayout/SingleMonitor.sh
# fi
