{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    extraConfig = ''
      set -g default-command "${pkgs.fish}/bin/fish -l -i"
    '';
  };
}
