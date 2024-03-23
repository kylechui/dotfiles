{ config, pkgs, ... }:

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
      font = "Iosevka Term 12";
    };
    theme =
      let
        inherit (config.lib.formats.rasi) mkLiteral;
      in
      {
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
}
