{ pkgs, ... }:

{
  #   # Create fcitx5 service
  #   systemd.services.bruhmoment = {
  #     description = "Fcitx5 Input Method";
  #     wantedBy = [ "graphical-session.target" ];
  #     serviceConfig = {
  #       ExecStart = "${pkgs.fcitx5}/bin/fcitx5";
  #       Restart = "always";
  #       Type = "simple";
  #     };
  #   };
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5 = {
      # Once home-manager has a module supporting configuration for fcitx5, this
      # can be removed.
      # The config files are stored in /etc/xdg/fcitx5, NOT ~/.config/fcitx5
      ignoreUserConfig = true;
      addons = [
        pkgs.fcitx5-chinese-addons
        pkgs.fcitx5-rime
        pkgs.fcitx5-gtk
        pkgs.fcitx5-nord
      ];
      settings = {
        addons = { classicui.globalSection.Theme = "Nord-Dark"; };
        globalOptions = { "Hotkey/TriggerKeys" = { "0" = "Alt+space"; }; };
        inputMethod = {
          "Groups/0" = {
            Name = "Default";
            "Default Layout" = "us";
            DefaultIM = "keyboard-us";
          };
          "Groups/0/Items/0" = {
            Name = "keyboard-us";
            Layout = "";
          };
          "Groups/0/Items/1" = {
            Name = "pinyin";
            Layout = "";
          };
          GroupOrder = { "0" = "Default"; };
        };
      };
    };
  };
}
