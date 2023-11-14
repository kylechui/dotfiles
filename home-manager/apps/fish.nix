{
  programs.fish = {
    enable = true;
    shellAliases = {
      e = "nvim";
      ll = "ls -al";
      rm = "rm -I";
      gst = "git status";
      nf = "nix flake";
      nfi = "nix flake init";
      nfu = "nix flake update";
      nd = "nix develop";
    };
    functions = {
      fish_user_key_bindings = { body = "bind -k nul accept-autosuggestion"; };
    };
  };
}
