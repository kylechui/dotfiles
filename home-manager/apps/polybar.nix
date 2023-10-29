{ pkgs, ... }:

let
  colors = {
    background = "#181820";
    background-alt = "#1f1f28";
    foreground = "#dcd7ba";
    foreground-alt = "#8a8980";
    primary = "#957fb8";
    muted = "#727169";
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
in {
  services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
      i3Support = true;
      pulseSupport = true;
    };
    script = "polybar -r top &";
    settings = {
      "bar/top" = {
        background = colors.background;
        foreground = colors.foreground;
        enable-ipc = true;
        font = [ "JetBrains Mono Nerd Font:size=12;2" ];
        height = 30;
        line-size = 4;
        module-margin-left = 1;
        module-margin-right = 1;
        modules-center = "date";
        modules-left = "cpu memory i3";
        modules-right = "wlan bluetooth pulseaudio battery";
        wm-restack = "i3";
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
        format = "%{A1:${pkgs.gsimplecal} &:}  <label>%{A}";
        format-underline = colors.foreground;
        format-padding = 1;
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
        label-connected = ''"%{A1:wifimenu:}%essid%%{A}"'';
        format-connected = "<ramp-signal> <label-connected>";
        format-connected-foreground = colors.red2;
        format-connected-underline = colors.red2;
        format-connected-padding = 1;
        label-disconnected = "%{A1:wifimenu:}󰤮 %{A}";
        label-disconnected-foreground = colors.foreground-alt;
        format-disconnected = "<label-disconnected>";
        format-disconnected-underline = colors.foreground-alt;
        format-disconnected-padding = 1;
      };
      "module/bluetooth" = {
        type = "custom/script";
        exec = "~/.config/polybar/bluetooth.sh";
        interval = 5;
        format =
          "%{A1:/run/current-system/sw/bin/blueman-manager &:}<label>%{A}";
        # format-foreground = colors.blue;
        format-underline = colors.blue;
        format-padding = 1;
      };
      "module/pulseaudio" = { # TODO: Figure this out!
        type = "internal/pulseaudio";
        interval = 1;
        format-muted = "<label-muted>";
        format-muted-prefix = "󰝟 ";
        format-muted-foreground = colors.muted;
        format-muted-underline = colors.muted;
        format-muted-padding = 1;
        format-volume = "%{A3:pavucontrol &:}<ramp-volume><label-volume>%{A}";
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

  xdg.configFile."polybar/bluetooth.sh" = {
    executable = true;
    text = ''
      DEVICE=$(${pkgs.bluez}/bin/bluetoothctl info \
        | ${pkgs.toybox}/bin/grep "Alias:" \
        | ${pkgs.toybox}/bin/head -n 1 \
        | ${pkgs.toybox}/bin/sed -E "s/\s+Alias: (.*)/\1/")
      if [[ ! -z $DEVICE ]]; then
        echo "%{F${colors.blue}}󰂯 $DEVICE"
      else
        echo "%{F${colors.foreground-alt}}󰂲"
      fi
    '';
  };
}
