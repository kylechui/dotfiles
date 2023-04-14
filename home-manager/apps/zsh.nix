{
  services.xcape.enable = true;
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    shellAliases = {
      e = "nvim";
      ll = "ls -al";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
      ];
      theme = "robbyrussell";
    };
    initExtra = ''
      bindkey '^ ' autosuggest-accept
      xmodmap -e "keycode 255 = Escape"
      xmodmap -e "clear Lock"

      xmodmap -e "keycode 66 = Super_L"
      xmodmap -e "add Mod4 = Super_L"

      xmodmap -e "keycode 9 = Caps_Lock"
      xmodmap -e "add Lock = Caps_Lock"

      xcape -e "Super_L=Escape"
    '';
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.autojump = {
    enable = true;
    enableZshIntegration = true;
  };
}
