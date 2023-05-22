{ config, ... }:

{
  programs.rofi = {
    enable = true;
    extraConfig = {
      kb-accept-entry = "Return";
      kb-row-up = "Up,Control+k";
      kb-row-down = "Down,Control+j";
      kb-remove-to-eol = "";
      disable-history = true;
      scroll-method = 1;
      drun-display-format = "{name}";
      display-drun = "Applications:";
      display-window = "Windows:";
      font = "JetBrainsMono Nerd Font Medium 11";
    };
    theme = let inherit (config.lib.formats.rasi) mkLiteral;
    in {
      "*" = {
        bg = mkLiteral "#1f1f28";
        bg-alt = mkLiteral "#2a2a37";
        bg-selected = mkLiteral "#363646";
        fg = mkLiteral "#dcd7ba";
        fg-alt = mkLiteral "#7f849c";
        focus = mkLiteral "#957fb8";
        border = 0;
        margin = 0;
        padding = 0;
        spacing = 0;
      };
      window = {
        width = mkLiteral "30%";
        background-color = mkLiteral "@bg";
      };
      element = {
        padding = mkLiteral "8 12";
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@fg-alt";
      };
      "element selected" = {
        text-color = mkLiteral "@fg";
        background-color = mkLiteral "@bg-selected";
      };
      element-text = {
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "inherit";
        vertical-align = mkLiteral "0.5";
      };
      element-icon = {
        size = 14;
        padding = mkLiteral "0 10 0 0";
        background-color = mkLiteral "transparent";
      };
      entry = {
        padding = 12;
        background-color = mkLiteral "@bg-alt";
        text-color = mkLiteral "@fg";
      };
      inputbar = {
        children = mkLiteral "[prompt, entry]";
        background-color = mkLiteral "@bg";
      };
      listview = {
        background-color = mkLiteral "@bg";
        columns = 1;
        lines = 10;
      };
      mainbox = {
        padding = 2;
        children = mkLiteral "[inputbar, listview]";
        background-color = mkLiteral "@focus";
      };
      prompt = {
        enabled = true;
        padding = mkLiteral "12 0 0 12";
        background-color = mkLiteral "@bg-alt";
        text-color = mkLiteral "@fg";
      };
    };
  };

  home.file.".config/rofi/wifi-connect.sh" = {
    executable = true;
    text = ''
      notify-send "Getting list of available Wi-Fi networks..."
      # Get a list of available wifi connections and morph it into a nice-looking list
      wifi_list=$(nmcli --fields "SECURITY,SSID" device wifi list | sed 1d | sed 's/  */ /g' | sed -E "s/WPA*.?\S/ /g" | sed "s/^--/ /g" | sed "s/  //g" | sed "/--/d" | sort | uniq)

      connected=$(nmcli -fields WIFI g)
      if [[ "$connected" =~ "enabled" ]]; then
      	toggle="睊  Disable Wi-Fi"
      elif [[ "$connected" =~ "disabled" ]]; then
      	toggle="直  Enable Wi-Fi"
      fi

      # Use rofi to select wifi network
      chosen_network=$(echo -e "$toggle\n$wifi_list" | rofi -dmenu -i -selected-row 1 -p "Wi-Fi SSID: " )
      # Get name of connection
      chosen_id=$(echo "''${chosen_network: 3}" | xargs)

      if [ "$chosen_network" = "" ]; then
        exit
      elif [ "$chosen_network" = "直  Enable Wi-Fi" ]; then
      	nmcli radio wifi on
      elif [ "$chosen_network" = "睊  Disable Wi-Fi" ]; then
          nmcli radio wifi off
      else
      	# Message to show when connection is activated successfully
      	success_message="You are now connected to the Wi-Fi network \"$chosen_id\"."
      	# Get saved connections
      	saved_connections=$(nmcli -g NAME connection)
      	if [[ $(echo "$saved_connections" | grep -w "$chosen_id") = "$chosen_id" ]]; then
      		nmcli connection up id "$chosen_id" | grep "successfully" && notify-send "Connection Established" "$success_message"
      	else
      		if [[ "$chosen_network" =~ "" ]]; then
      			wifi_password=$(rofi -dmenu -p "Password: " )
      		fi
      		nmcli device wifi connect "$chosen_id" password "$wifi_password" | grep "successfully" && notify-send "Connection Established" "$success_message"
      	fi
      fi
    '';
  };
}
