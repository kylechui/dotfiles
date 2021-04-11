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

  killall -q polybar picom feh dunst xautolock xcompmgr nm-applet blueman-applet
  feh --no-xinerama --bg-scale $HOME/.wallpapers/gruvbox.png &

  setxkbmap -option "caps:swapescape"
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
