{
  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    shellAliases = {
      e = "nvim";
      ll = "ls -al";
      rm = "rm -I";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "robbyrussell";
    };
    initExtra = ''
      bindkey '^ ' autosuggest-accept
      eval "$(zoxide init zsh)"
    '';
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}
