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
    green = "#76946a";
    red = "#c4746e";
    orange = "#ffa066";
    teal = "#949fb5";
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
        modules-right =
          "wlan pulseaudio battery"; # microphone xbacklight popup-calendar time";
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
        format =
          "%{A1:/etc/profiles/per-user/kylec/bin/gsimplecal:}  <label>%{A}";
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
        format-connected = "<ramp-signal> <label-connected>";
        label-connected = ''"%{A1:wifimenu:}%essid%%{A}"'';
        format-disconnected = "<label-disconnected>";
        label-disconnected = "%{A1:wifimenu:}󰤮 %{A}";
        label-disconnected-foreground = colors.foreground-alt;
        format-padding = 1;
      };
      "module/pulseaudio" = { # TODO: Figure this out!
        type = "internal/pulseaudio";
        interval = 1;
        format-muted = "<label-muted>";
        format-muted-prefix = "󰝟 ";
        format-muted-foreground = colors.muted;
        # format-volume = "%{A3:rofi-pulseaudio:}<ramp-volume> <label-volume>%{A}";
        format-volume = "<ramp-volume><label-volume>";
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
        label-low-underline = colors.red;
        format-full-prefix = "󰁹";
        format-full-foreground = colors.green;
        format-full-underline = colors.green;
        format-discharging = "<ramp-capacity> <label-discharging>";
        format-charging = "<animation-charging> <label-charging>";
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
    # extraConfig = ''
    #   [colors]
    #   background = #1d2021
    #   foreground = #ebdbb2
    #   foreground-alt = #928374
    #   primary = #ffb52a
    #   secondary = #ee6137
    #   muted = #5c5551
    #   urgent = #bd2c40
    #
    #   [settings]
    #   throttle-output = 5
    #   throttle-output-for = 10
    #   compositing-foreground = lighten
    #   compositing-background = source
    #   ; compositing-foreground = over
    #   ; compositing-overline = over
    #   ; compositing-underline = over
    #   ; compositing-border = over
    #
    #   [bar/top-gap]
    #   dpi = ''${xrdb:Xft.dpi:96}
    #   height = ''${xrdb:polybar.height:32}
    #   width = 100%
    #   background = ''${colors.background}
    #   foreground = ''${colors.background}
    #   modules-left = blank
    #
    #   [bar/top]
    #   dpi = ''${xrdb:Xft.dpi:96}
    #   width = 100%
    #   height = ''${xrdb:polybar.height:32}
    #   radius = 0.0
    #   fixed-center = true
    #
    #   background = ''${colors.background}
    #   foreground = ''${colors.foreground}
    #
    #   spacing = 0
    #
    #   border-size = 0
    #
    #   padding-left = 1
    #   padding-right = 1
    #
    #   module-margin-left = 1
    #   module-margin-right = 1
    #
    #   font-0 = Iosevka Term:pixelsize=10;2
    #   font-1 = Font Awesome 5 Free:style=Solid:pixelsize=12;2
    #   font-2 = Font Awesome 5 Brands:style=Solid:pixelsize=12;2
    #   font-3 = TerminessTTF Nerd Font:style=Solid:pixelsize=12;2
    #   font-4 = monospace:pixelsize=10;2
    #   font-5 = sans:pixelsize=10;2
    #
    #   modules-left = memory cpu spotify
    #   modules-center = i3
    #   modules-right = battery microphone volume xbacklight packages popup-calendar time
    #
    #   tray-position = left
    #   tray-padding = 2
    #   tray-maxsize = 24
    #
    #   wm-restack = i3
    #
    #   enable-ipc = true
    #
    #   [module/blank]
    #   type = custom/text
    #   content =  
    #
    #   [module/xwindow]
    #   type = internal/xwindow
    #   label = %title:0:30:...%
    #
    #   [module/xbacklight]
    #   type = internal/xbacklight
    #   format = <ramp> <label>
    #   label = %percentage%%
    #   ramp-0 = 
    #   ramp-1 = 
    #   ramp-2 = 
    #   ramp-3 = 
    #   ramp-4 = 
    #   ramp-5 = 
    #
    #   ; Use the following command to list available cards:
    #   ; $ ls -1 /sys/class/backlight/
    #   card = intel_backlight
    #
    #   [module/i3]
    #   type = internal/i3
    #   index-sort = true
    #   wrapping-scroll = false
    #   strip-wsnumbers = true
    #
    #   ; Available tags:
    #   ;   <label-state> (default) - gets replaced with <label-(focused|unfocused|visible|urgent)>
    #   ;   <label-mode> (default)
    #   format = <label-state> <label-mode>
    #
    #   ; Available tokens:
    #   ;   %mode%
    #   ; Default: %mode%
    #   label-mode = %mode%
    #   label-mode-padding = 2
    #   label-mode-background = ''${colors.background}
    #   label-mode-foreground = ''${colors.secondary}
    #
    #   ; Available tokens:
    #   ;   %name%
    #   ;   %icon%
    #   ;   %index%
    #   ;   %output%
    #   ; Default: %icon%  %name%
    #   ; label-focused = %{R}%icon% %name%
    #   label-focused-foreground = ''${colors.primary}
    #   label-focused-padding-right = 1
    #
    #   ; Available tokens:
    #   ;   %name%
    #   ;   %icon%
    #   ;   %index%
    #   ; Default: %icon%  %name%
    #   label-unfocused-foreground = ''${colors.foreground}
    #   label-unfocused-padding-right = 1
    #
    #   ; Available tokens:
    #   ;   %name%
    #   ;   %icon%
    #   ;   %index%
    #   ; Default: %icon%  %name%
    #   label-visible-padding-right = 1
    #
    #   ; Available tokens:
    #   ;   %name%
    #   ;   %icon%
    #   ;   %index%
    #   ; Default: %icon%  %name%
    #   label-urgent-foreground = ''${colors.foreground}
    #   label-urgent-background = ''${colors.urgent}
    #   label-urgent-padding-right = 1
    #
    #   [module/cpu]
    #   type = internal/cpu
    #   interval = 2
    #   format-prefix = 
    #   format-prefix-foreground = ''${colors.foreground}
    #   format = <label> <ramp-coreload>
    #   label = %percentage:3%%
    #
    #   ramp-coreload-0 = %{O-4}▁
    #
    #   ramp-coreload-0-foreground = #5f819d
    #   ramp-coreload-1 = %{O-4}▂
    #   ramp-coreload-1-foreground = #5f819d
    #   ramp-coreload-2 = %{O-4}▃
    #   ramp-coreload-2-foreground = #f0c674
    #   ramp-coreload-3 = %{O-4}▄
    #   ramp-coreload-3-foreground = #f0c674
    #   ramp-coreload-4 = %{O-4}▅
    #   ramp-coreload-4-foreground = #de935f
    #   ramp-coreload-5 = %{O-4}▆
    #   ramp-coreload-5-foreground = #de935f
    #   ramp-coreload-6 = %{O-4}▇
    #   ramp-coreload-6-foreground = #a54242
    #   ramp-coreload-7 = %{O-4}█
    #   ramp-coreload-7-foreground = #a54242
    #
    #   [module/memory]
    #   type = internal/memory
    #   interval = 2
    #   format = <label> <bar-used>
    #   format-prefix = 
    #   format-prefix-foreground = ''${colors.foreground}
    #
    #   label = %gb_used:8%/%gb_total%
    #
    #   ; Only applies if <bar-used> is used
    #   bar-used-indicator =
    #   bar-used-width = 14
    #   bar-used-foreground-0 = #55aa55
    #   bar-used-foreground-1 = #557755
    #   bar-used-foreground-2 = #f5a70a
    #   bar-used-foreground-3 = #ff5555
    #   bar-used-fill = %{O-1}█
    #   bar-used-empty = %{O-1}▁
    #   bar-used-empty-foreground = #666
    #
    #   [module/wired-network]
    #   type = internal/network
    #   interface = eth1
    #   interval = 3.0
    #
    #   ; Available tags:
    #   ;   <label-connected> (default)
    #   ;   <ramp-signal>
    #   format-connected = <ramp-signal> <label-connected>
    #
    #   ; Available tags:
    #   ;   <label-disconnected> (default)
    #   format-disconnected = <label-disconnected>
    #
    #   ; Available tags:
    #   ;   <label-connected> (default)
    #   ;   <label-packetloss>
    #   ;   <animation-packetloss>
    #   format-packetloss = <animation-packetloss> <label-connected>
    #
    #   ; Available tokens:
    #   ;   %ifname%    [wireless+wired]
    #   ;   %local_ip%  [wireless+wired]
    #   ;   %essid%     [wireless]
    #   ;   %signal%    [wireless]
    #   ;   %upspeed%   [wireless+wired]
    #   ;   %downspeed% [wireless+wired]
    #   ;   %linkspeed% [wired]
    #   ; Default: %ifname% %local_ip%
    #   label-connected = %{F#66aa66}%linkspeed%%{F-} %{T2} %downspeed:7%  %upspeed:7%%{T-}
    #
    #   ; Available tokens:
    #   ;   %ifname%    [wireless+wired]
    #   ; Default: (none)
    #   ; label-disconnected = not connected
    #   ; label-disconnected-foreground = #66ffffff
    #
    #   ramp-signal-0 = " "
    #   format-prefix-foreground = ''${colors.foreground}
    #
    #   [module/wireless-network]
    #   type = internal/network
    #   interface = wlo1
    #   interval = 3.0
    #
    #   ; Available tags:
    #   ;   <label-connected> (default)
    #   ;   <ramp-signal>
    #   format-connected = <ramp-signal> <label-connected>
    #
    #   ; Available tags:
    #   ;   <label-disconnected> (default)
    #   format-disconnected = <label-disconnected>
    #
    #   ; Available tags:
    #   ;   <label-connected> (default)
    #   ;   <label-packetloss>
    #   ;   <animation-packetloss>
    #   format-packetloss = <animation-packetloss> <label-connected>
    #
    #   ; Available tokens:
    #   ;   %ifname%    [wireless+wired]
    #   ;   %local_ip%  [wireless+wired]
    #   ;   %essid%     [wireless]
    #   ;   %signal%    [wireless]
    #   ;   %upspeed%   [wireless+wired]
    #   ;   %downspeed% [wireless+wired]
    #   ;   %linkspeed% [wired]
    #   ; Default: %ifname% %local_ip%
    #   label-connected = %{F#66aa66}%essid%%{F-} %{T2} %downspeed:7%  %upspeed:7%%{T-}
    #
    #   ; Available tokens:
    #   ;   %ifname%    [wireless+wired]
    #   ; Default: (none)
    #   ; label-disconnected = not connected
    #   ; label-disconnected-foreground = #66ffffff
    #
    #   ramp-signal-0 = " "
    #   format-prefix-foreground = ''${colors.foreground}
    #   ; format-disconnected-underline = #ff7f7f
    #   ; format-connected-underline = #7fff7f
    #
    #   [module/popup-calendar]
    #   type = custom/script
    #   exec = ~/.config/polybar/popup-calendar.sh
    #   interval = 5
    #   click-left = ~/.config/polybar/popup-calendar.sh --popup &
    #   format-prefix = 
    #
    #   [module/time]
    #   type = internal/date
    #   interval = 1
    #
    #   time = %H:%M:%S
    #   time-alt = %H:%M:%S
    #
    #   format-prefix =  
    #   label = %time%
    #   format-prefix-foreground = ''${colors.foreground}
    #   format-label-foreground = ''${colors.urgent}
    #
    #   [module/microphone]
    #   type = custom/ipc
    #
    #   hook-0 = ~/.config/polybar/mic-volume.sh show-vol
    #   initial = 1
    #
    #   click-left = ~/.config/polybar/mic-volume.sh mute-vol; polybar-msg -p %pid% hook microphone 1
    #   scroll-up = ~/.config/polybar/mic-volume.sh inc-vol; polybar-msg -p %pid% hook microphone 1
    #   scroll-down = ~/.config/polybar/mic-volume.sh dec-vol; polybar-msg -p %pid% hook microphone 1
    #   click-right = /usr/bin/python3 ~/bin/scripts/rofi_audio_set_default_source.py
    #
    #   ; [module/microphone]
    #   ; type = custom/script
    #   ; 
    #   ; interval = 1
    #   ; exec = ~/.config/polybar/microphone.sh
    #   ; 
    #   ; click-left = exec amixer set Dmic0 toggle
    #   ; scroll-up = exec amixer set Dmic0 1%+
    #   ; scroll-down = exec amixer set Dmic0 1%-
    #   ; click-right = rofi-pulseaudio source output
    #
    #   [module/battery]
    #   type = internal/battery
    #   battery = BAT0
    #   adapter = AC
    #   full-at = 100
    #
    #   ; see "man date" for details on how to format the time string
    #   ; NOTE: if you want to use syntax tags here you need to use %%{...}
    #   ; Default: %H:%M:%S
    #   time-format = %H:%M
    #
    #   ; Available tags:
    #   ;   <label-charging> (default)
    #   ;   <bar-capacity>
    #   ;   <ramp-capacity>
    #   ;   <animation-charging>
    #
    #   ; Available tags:
    #   ;   <label-discharging> (default)
    #   ;   <bar-capacity>
    #   ;   <ramp-capacity>
    #
    #   ; Available tags:
    #   ;   <label-full> (default)
    #   ;   <bar-capacity>
    #   ;   <ramp-capacity>
    #   format-full =
    #
    #   ; Available tokens:
    #   ;   %percentage% (default)
    #   ;   %time%
    #   ;   %consumption% (shows current charge rate in watts)
    #   label-charging = %percentage%% (%time%)
    #
    #   ; Available tokens:
    #   ;   %percentage% (default)
    #   ;   %time%
    #   ;   %consumption% (shows current discharge rate in watts)
    #   label-discharging = %percentage%% (%time%)
    #
    #   ; Available tokens:
    #   ;   %percentage% (default)
    #   label-full = Charged
    #
    #   [global/wm]
    #   margin-top = 5
    #   margin-bottom = 5
    #
    #   [module/spotify]
    #   type = custom/script
    #   exec = ~/.config/polybar/spotify.sh
    #   exec-if = pgrep -x spotify
    #   tail = true
    #   ; interval = 0
    #   format-prefix =
    #   format-padding = 1
    #
    #   [module/packages]
    #   type = custom/script
    #   exec = ~/.config/polybar/packages.sh
    #   tail = true
    #   interval = 3600
    #   format-padding = 0
    #
    #   [module/dunst]
    #   type = custom/ipc
    #
    #   hook-0 = pkill dunst -USR2 ; echo %{F$(xgetres foreground)}%{F-}
    #   hook-1 = pkill dunst -USR1 ; echo %{F$(xgetres color2)}%{F-}
    #   initial = 1
    #
    #   click-left  = polybar-msg -p %pid% hook dunst 1
    #   click-right = polybar-msg -p %pid% hook dunst 2
    # '';
  };
}
