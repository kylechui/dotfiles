#!/usr/bin/env bash

set -x

dropbox-run() {
  if command -v dropbox-cli; then
    dropbox-cli "$@"
  else
    dropbox "$@"
  fi
}

main() {
  # Set key repeat delay and speed
  xset r rate 280 40
  # Set trackpad acceleration speed
  xinput set-prop "SYNA3297:00 06CB:CD50 Touchpad" "libinput Accel Speed" 0.1
  # Set trackpad tap to click
  xinput set-prop "SYNA3297:00 06CB:CD50 Touchpad" "libinput Tapping Enabled" 1
  # Set natural scrolling
  xinput set-prop "SYNA3297:00 06CB:CD50 Touchpad" "libinput Natural Scrolling Enabled" 1

  xmodmap -e "keycode 255 = Escape"
  xmodmap -e "clear Lock"

  xmodmap -e "keycode 66 = Super_L"
  xmodmap -e "add Mod4 = Super_L"

  xmodmap -e "keycode 9 = Caps_Lock"
  xmodmap -e "add Lock = Caps_Lock"

  xcape -e "Super_L=Escape"

  killall -q polybar picom feh dunst xautolock xcompmgr nm-applet blueman-applet
  feh --no-xinerama --bg-scale $HOME/.wallpapers/gruvbox.png &

  sleep 1 & 

  polybar -r top & sleep 1 &
  dunst & sleep 1 &
  nm-applet & sleep 1 &
  blueman-applet &

  xcompmgr -c -l0 -t0 -r0 -o.00 &

  xautolock -detectsleep \
    -corners ---- \
    -notify   4 -notifier "xset s activate" \
    -time     5 -locker   "lock-session" &
}

main "$@"
