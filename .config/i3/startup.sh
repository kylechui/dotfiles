#!/usr/bin/env bash

set -x

TOUCHPAD="SYNA3297:00 06CB:CD50 Touchpad" 

main() {
  # Set key repeat delay and speed
  xset r rate 280 40
  # Set trackpad acceleration speed
  xinput set-prop "$TOUCHPAD" "libinput Accel Speed" 0.1
  # Set trackpad tap to click
  xinput set-prop "$TOUCHPAD" "libinput Tapping Enabled" 1
  # Set natural scrolling
  xinput set-prop "$TOUCHPAD" "libinput Natural Scrolling Enabled" 1
  # Disable touchscreen
  xinput disable "ELAN2514:00 04F3:29E0"

    # spare_modifier="Hyper_L"
    # xmodmap -e "keycode 66 = $spare_modifier"
    # # xmodmap -e "remove mod4 = $spare_modifier" # hyper_l is mod4 by default
    # # xmodmap -e "add Control = $spare_modifier"
    #
    # # Map space to an unused keycode (to keep it around for xcape to
    # # use).
    # xmodmap -e "keycode 255 = Escape"
    #
    # # Finally use xcape to cause the escape key to work
    # xcape -e "$spare_modifier=Escape"

  xmodmap -e "keycode 255 = Escape"
  xmodmap -e "clear Lock"

  xmodmap -e "keycode 66 = Super_L"
  xmodmap -e "add Mod4 = Super_L"

  xmodmap -e "keycode 9 = Caps_Lock"
  xmodmap -e "add Lock = Caps_Lock"

  xcape -e "Super_L=Escape"

  killall -q polybar picom feh dunst xautolock xcompmgr nm-applet blueman-applet
  feh --no-xinerama --bg-scale $HOME/.wallpapers/gruvbox.png &
   
  polybar -r top &
  nm-applet &
  blueman-applet &
  dunst & 

  xcompmgr -c -l0 -t0 -r0 -o.00 &

  xautolock -detectsleep \
    -corners ---- \
    -notify   4 -notifier "xset s activate" \
    -time     5 -locker   "lock-session" &
}

main "$@"
