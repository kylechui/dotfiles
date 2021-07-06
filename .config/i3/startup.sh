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
  # dropbox-run stop
  # while pgrep -x dropbox >/dev/null; do
  #   sleep 1;
  # done
  xset r rate 280 40
  # xmodmap ~/.Xmodmap
  xmodmap -e "keycode 255 = Escape"
  xmodmap -e "clear Lock"

  xmodmap -e "keycode 66 = Super_L"
  xmodmap -e "add Mod4 = Super_L"

  xmodmap -e "keycode 9 = Caps_Lock"
  xmodmap -e "add Lock = Caps_Lock"

  xcape -e 'Super_L=Escape;Shift_L=Shift_L|9;Shift_R=Shift_R|0'

  killall -q polybar picom feh dunst xautolock xcompmgr nm-applet blueman-applet
  feh --no-xinerama --bg-scale $HOME/.wallpapers/gruvbox.png &

  polybar -r top &

  dunst &
  nm-applet &
  blueman-applet &

  # dropbox-run start
  # xbanish &

  # picom -b --experimental-backends
  xcompmgr -c -l0 -t0 -r0 -o.00 &

  xautolock -detectsleep \
    -corners ---- \
    -notify   4 -notifier "xset s activate" \
    -time     5 -locker   "lock-session" &
}

main "$@"
