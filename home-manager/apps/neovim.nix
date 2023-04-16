{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
}
