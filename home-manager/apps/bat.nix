{ pkgs, ... }:

{
  programs.bat = {
    enable = true;
    config.theme = "modus_operandi";
    themes = {
      modus_operandi = builtins.readFile ./modus_operandi.tmTheme;
    };
  };
}
