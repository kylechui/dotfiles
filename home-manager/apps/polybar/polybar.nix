{ pkgs, ... }:

let
  colors = {
    background = "#181820";
    background-alt = "#1f1f28";
    foreground = "#dcd7ba";
    foreground-alt = "#727169";
    primary = "#957fb8";
    urgent = "#c34043";
    red = "#c4746e";
    red2 = "#d9a594";
    yellow = "#f9d791";
    orange = "#ffa066";
    green = "#76946a";
    blue = "#7e9cd8";
    violet = "#9cabca";
    teal = "#949fb5";
    pink = "#d27e99";
  };
  polybar = (
    pkgs.polybar.override {
      i3Support = true;
      pulseSupport = true;
    }
  );
in
{
  services.polybar = {
    enable = true;
    package = polybar;
    script = ''
      # Necessary for giving polybar access to the playerctl libraries
      export GI_TYPELIB_PATH="${
        pkgs.lib.makeSearchPath "lib/girepository-1.0" [ pkgs.playerctl ]
      }:$GI_TYPELIB_PATH"
      export PATH="${
        pkgs.lib.makeBinPath [
          (pkgs.python311.withPackages (ps: [ ps.pygobject3 ]))
          pkgs.playerctl
        ]
      }:$PATH"
      ${polybar}/bin/polybar &
    '';
    settings = {
      "bar/default" = {
        background = colors.background;
        foreground = colors.foreground;
        enable-ipc = true;
        font = [
          "Iosevka:size=12;2"
          "Symbols Nerd Font Mono:size=12;2"
          "Sarasa Gothic J:size=12;2"
        ];
        height = 30;
        line-size = 4;
        module-margin-left = 1;
        module-margin-right = 1;
        modules-center = "date";
        modules-left = "cpu memory i3";
        modules-right = "mpris wlan bluetooth pulseaudio battery";
      };
      "module/cpu" = {
        type = "internal/cpu";
        interval = 2;
        label = "%percentage:2%%";
        format-prefix = " ";
        format-foreground = colors.teal;
        format-underline = colors.teal;
        format-padding = 1;
      };
      "module/memory" = {
        type = "internal/memory";
        interval = 2;
        label = "%gb_used:8%/%gb_total%";
        format-prefix = " ";
        format-foreground = colors.orange;
        format-underline = colors.orange;
        format-padding = 1;
      };
      "module/i3" = {
        type = "internal/i3";
        index-sort = true;
        enable-scroll = false;
        label-focused-foreground = colors.primary;
        label-focused-background = colors.background-alt;
        label-focused-underline = colors.primary;
        label-focused = "%index%";
        label-unfocused = "%index%";
        label-focused-padding = 1;
        label-unfocused-padding = 1;
      };
      "module/date" = {
        type = "internal/date";
        interval = 1;
        date = "%Y-%m-%d%";
        time = "%H:%M:%S";
        label = "%date%  %time%";
        format = "%{A1:${pkgs.gsimplecal}/bin/gsimplecal &:}  <label>%{A}";
        format-underline = colors.foreground;
        format-padding = 1;
      };
      "module/mpris" = {
        type = "custom/script";
        exec = pkgs.writeScript "mpris_status" (builtins.readFile ./mpris_status.py);
        tail = true;
        click-left = "${pkgs.playerctl}/bin/playerctl play-pause";
        scroll-up = "${pkgs.playerctl}/bin/playerctl previous";
        scroll-down = "${pkgs.playerctl}/bin/playerctl next";
      };
      "module/wlan" = {
        type = "internal/network";
        interface = "wlo1";
        interface-type = "wireless";
        interval = 1;
        ramp-signal-0 = "󰤯";
        ramp-signal-1 = "󰤟";
        ramp-signal-2 = "󰤢";
        ramp-signal-3 = "󰤥";
        ramp-signal-4 = "󰤨";
        label-connected = ''"%{A1:${pkgs.networkmanagerapplet}/bin/nm-connection-editor:}%essid%%{A}"'';
        format-connected = "<ramp-signal> <label-connected>";
        format-connected-foreground = colors.red2;
        format-connected-underline = colors.red2;
        format-connected-padding = 1;
        label-disconnected = "%{A1:${pkgs.networkmanagerapplet}/bin/nm-connection-editor:}󰤮%{A}";
        label-disconnected-foreground = colors.foreground-alt;
        format-disconnected = "<label-disconnected>";
        format-disconnected-underline = colors.foreground-alt;
        format-disconnected-padding = 1;
      };
      "module/bluetooth" = {
        type = "custom/script";
        exec = pkgs.writeShellScript "bluetooth.sh" ''
          BLUETOOTH_ON=$(${pkgs.bluez}/bin/bluetoothctl show \
            | ${pkgs.gnugrep}/bin/grep "Powered: yes")
          DEVICE=$(${pkgs.bluez}/bin/bluetoothctl info \
            | ${pkgs.gnugrep}/bin/grep "Alias:" \
            | ${pkgs.coreutils}/bin/head -n 1 \
            | ${pkgs.gnused}/bin/sed -E "s/\s+Alias: (.*)/\1/")
          if [[ -z $BLUETOOTH_ON ]]; then
            echo "%{+u}%{F${colors.foreground-alt}}%{u${colors.foreground-alt}} 󰂲 %{u-}%{F-}"
          elif [[ -z $DEVICE ]]; then
            echo "%{+u}%{F${colors.blue}}%{u${colors.blue}} 󰂯 %{u-}%{F-}"
          else
            echo "%{+u}%{F${colors.blue}}%{u${colors.blue}} 󰂯 $DEVICE %{u-}%{F-}"
          fi
        '';
        interval = 3;
        format = "%{A1:${pkgs.blueman}/bin/blueman-manager &:}<label>%{A}";
      };
      "module/pulseaudio" = {
        # TODO: Figure this out!
        type = "internal/pulseaudio";
        interval = 1;
        format-muted = "<label-muted>";
        format-muted-prefix = "󰝟 ";
        format-muted-foreground = colors.foreground-alt;
        format-muted-underline = colors.foreground-alt;
        format-muted-padding = 1;
        format-volume = "%{A3:${pkgs.pavucontrol}/bin/pavucontrol &:}<ramp-volume><label-volume>%{A}";
        format-volume-foreground = colors.pink;
        format-volume-underline = colors.pink;
        format-volume-padding = 1;
        ramp-volume-0 = " ";
        ramp-volume-1 = " ";
        ramp-volume-2 = " ";
        click-right = "pavucontrol";
        use-ui-max = false;
      };
      "module/battery" = {
        type = "internal/battery";
        battery = "BAT0";
        low-at = 30;
        full-at = 98;
        format-low-prefix = "󰂃";
        format-low-foreground = colors.red;
        format-low-underline = colors.red;
        format-full-prefix = "󰁹";
        format-full-foreground = colors.green;
        format-full-underline = colors.green;
        format-charging = "<animation-charging> <label-charging>";
        format-charging-foreground = colors.green;
        format-charging-underline = colors.green;
        format-discharging = "<ramp-capacity> <label-discharging>";
        format-discharging-foreground = colors.yellow;
        format-discharging-underline = colors.yellow;
        ramp-capacity-0 = "󰁺";
        ramp-capacity-1 = "󰁼";
        ramp-capacity-2 = "󰁾";
        ramp-capacity-3 = "󰂀";
        ramp-capacity-4 = "󰂂";
        animation-charging-framerate = 750;
        animation-charging-0 = "󰁺";
        animation-charging-1 = "󰁼";
        animation-charging-2 = "󰁾";
        animation-charging-3 = "󰂀";
        animation-charging-4 = "󰂂";
        label-low-padding = "5px";
        label-full-padding = "5px";
        label-charging-padding = "5px";
        label-discharging-padding = "5px";
        format-low-padding = 1;
        format-full-padding = 1;
        format-charging-padding = 1;
        format-discharging-padding = 1;
      };
    };
  };

  xdg.configFile."gsimplecal/config" = {
    text = ''
      close_on_unfocus = 1
      mainwindow_yoffset = 10
    '';
  };
}
