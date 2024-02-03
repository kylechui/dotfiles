{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    terminal = "screen-256color";
    extraConfig = ''
      # Set the default prompt to fish, without overriding the default shell
      set -g default-command "${pkgs.fish}/bin/fish -l -i"
      # Enable tmux true color support
      set -sa terminal-features ",xterm-256color:RGB"
      # Avoid laggy escape key in nvim
      set -sg escape-time 0
    '';
  };
}
