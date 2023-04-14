{
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
