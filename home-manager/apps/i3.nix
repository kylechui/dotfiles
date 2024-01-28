{ pkgs, ... }:

let mod = "Mod4";
in {
  xsession = {
    enable = true;
    windowManager.i3 = {
      enable = true;
      config = {
        startup = [
          {
            command = "${pkgs.polybar}/bin/polybar-msg cmd restart";
            always = true;
            notification = false;
          }
          {
            command = "${pkgs.autorandr}/bin/autorandr --change";
            always = true;
            notification = false;
          }
          {
            # Disable laptop touchscreen
            command = "xinput disable 'ELAN2514:00 04F3:29E0'";
            always = true;
            notification = false;
          }
          {
            # TODO: Figure out why providing raw path doesn't work
            # Environment variables are likely not set properly
            command = "fcitx5 -d -r";
            always = true;
            notification = false;
          }
          {
            # TODO: Figure out why providing raw path doesn't work
            # Using /run/wrappers/bin/noisetorch doesn't work either
            command = "noisetorch -i";
            always = true;
            notification = false;
          }
        ];
        modifier = mod;
        assigns = { "8" = [{ class = "discord"; }]; };
        window = {
          titlebar = false;
          commands = [{
            command = "move to workspace number 9";
            criteria = { class = "Spotify"; };
          }];
        };
        defaultWorkspace = "workspace number 1";
        bars = [ ];
        colors = {
          focused = {
            border = "#4c7899";
            background = "#285577";
            text = "#ffffff";
            indicator = "#aa6c39";
            childBorder = "#957fb8";
          };
        };
        focus = {
          followMouse = false;
          newWindow = "focus";
          wrapping = "no";
        };
        fonts = {
          names = [ "TerminessTTF Nerd Font" ];
          style = "Bold Semi-Condensed";
          size = 10.0;
        };
        gaps = { smartBorders = "on"; };
        keybindings = {
          "${mod}+Tab" = "workspace back_and_forth";
          "${mod}+space" = "exec ${pkgs.rofi}/bin/rofi -show drun";
          "${mod}+Return" = "exec ${pkgs.wezterm}/bin/wezterm";
          "${mod}+Shift+Return" = "exec ${pkgs.firefox}/bin/firefox";
          "${mod}+p" = "exec ${pkgs.firefox}/bin/firefox --private-window";
          "${mod}+BackSpace" = "split toggle";
          "${mod}+Shift+s" =
            "exec --no-startup-id ${pkgs.flameshot}/bin/flameshot gui";
          "${mod}+w" = "exec --no-startup-id ~/.config/rofi/wifi-connect.sh &";
          "${mod}+e" = "exec ${pkgs.xfce.thunar}/bin/thunar";
          "${mod}+x" = "split h";
          "${mod}+v" = "split v";
          "${mod}+Shift+e" = ''
            exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -b 'Yes, exit i3' 'i3-msg exit'"'';
          "${mod}+Escape" =
            "exec ${pkgs.betterlockscreen}/bin/betterlockscreen --lock --quiet";
          "${mod}+Shift+q" = "kill";
          "${mod}+f" = "fullscreen toggle";
          "${mod}+Shift+f" = "floating toggle";
          "${mod}+Shift+r" = "restart";
          "${mod}+Shift+c" = "reload";
          # Laptop keys
          "XF86MonBrightnessDown" =
            "exec --no-startup-id ${pkgs.brightnessctl}/bin/brightnessctl -d 'intel_backlight' set 5%-";
          "XF86MonBrightnessUp" =
            "exec --no-startup-id ${pkgs.brightnessctl}/bin/brightnessctl -d 'intel_backlight' set +5%";
          "XF86AudioLowerVolume" =
            "exec --no-startup-id ${pkgs.pulseaudio}/bin/pactl set-sink-volume 1 -5%";
          "XF86AudioRaiseVolume" =
            "exec --no-startup-id ${pkgs.pulseaudio}/bin/pactl set-sink-volume 1 +5%";
          "XF86AudioPrev" =
            "exec --no-startup-id ${pkgs.playerctl}/bin/playerctl previous";
          "XF86AudioPause" =
            "exec --no-startup-id ${pkgs.playerctl}/bin/playerctl play-pause";
          "XF86AudioNext" =
            "exec --no-startup-id ${pkgs.playerctl}/bin/playerctl next";
          "XF86AudioMute" =
            "exec --no-startup-id ${pkgs.pulseaudio}/bin/pactl set-sink-mute 1 toggle";
          # Basic navigation keybinds
          "${mod}+h" = "focus left";
          "${mod}+j" = "focus down";
          "${mod}+k" = "focus up";
          "${mod}+l" = "focus right";
          "${mod}+Shift+h" = "move left";
          "${mod}+Shift+j" = "move down";
          "${mod}+Shift+k" = "move up";
          "${mod}+Shift+l" = "move right";
          "${mod}+Left" = "focus left";
          "${mod}+Down" = "focus down";
          "${mod}+Up" = "focus up";
          "${mod}+Right" = "focus right";
          "${mod}+Shift+Left" = "move left";
          "${mod}+Shift+Down" = "move down";
          "${mod}+Shift+Up" = "move up";
          "${mod}+Shift+Right" = "move right";
          "${mod}+1" = "workspace number 1";
          "${mod}+2" = "workspace number 2";
          "${mod}+3" = "workspace number 3";
          "${mod}+4" = "workspace number 4";
          "${mod}+5" = "workspace number 5";
          "${mod}+6" = "workspace number 6";
          "${mod}+7" = "workspace number 7";
          "${mod}+8" = "workspace number 8";
          "${mod}+9" = "workspace number 9";
          "${mod}+0" = "workspace number 10";
          "${mod}+Shift+1" = "move container to workspace number 1";
          "${mod}+Shift+2" = "move container to workspace number 2";
          "${mod}+Shift+3" = "move container to workspace number 3";
          "${mod}+Shift+4" = "move container to workspace number 4";
          "${mod}+Shift+5" = "move container to workspace number 5";
          "${mod}+Shift+6" = "move container to workspace number 6";
          "${mod}+Shift+7" = "move container to workspace number 7";
          "${mod}+Shift+8" = "move container to workspace number 8";
          "${mod}+Shift+9" = "move container to workspace number 9";
          "${mod}+Shift+0" = "move container to workspace number 10";
        };
        keycodebindings = let # Logiops keycode bindings (set in logiops.nix)
          gesture_left = "193";
          gesture_right = "194";
          gesture_down = "195";
          gesture_up = "196";
        in {
          ${gesture_left} = "workspace next";
          ${gesture_right} = "workspace prev";
          ${gesture_down} =
            "exec --no-startup-id ${pkgs.flameshot}/bin/flameshot gui";
          ${gesture_up} =
            "exec --no-startup-id ${pkgs.xcolor}/bin/xcolor -s clipboard";
        };
      };
      # TODO: Fix this!
      # extraConfig = ''
      #
      # # resize window (you can also use the mouse for that)
      # mode "resize" {
      #   # These bindings trigger as soon as you enter the resize mode
      #
      #   # Pressing left will shrink the window’s width.
      #   # Pressing right will grow the window’s width.
      #   # Pressing up will shrink the window’s height.
      #   # Pressing down will grow the window’s height.
      #   bindsym h resize shrink width 10 px or 10 ppt
      #   bindsym j resize grow height 10 px or 10 ppt
      #   bindsym k resize shrink height 10 px or 10 ppt
      #   bindsym l resize grow width 10 px or 10 ppt
      #
      #   # same bindings, but for the arrow keys
      #   bindsym Left resize shrink width 10 px or 10 ppt
      #   bindsym Down resize grow height 10 px or 10 ppt
      #   bindsym Up resize shrink height 10 px or 10 ppt
      #   bindsym Right resize grow width 10 px or 10 ppt
      #
      #   # back to normal: Enter or Escape
      #   bindsym Return mode "default"
      #   bindsym Escape mode "default"
      # }
      #
      # bindsym $mod+r mode "resize"
      #
      # '';
    };
  };
}
