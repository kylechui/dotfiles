{
  programs.zathura = {
    enable = true;
    extraConfig = builtins.readFile ./.zathurarc;
  };
}
