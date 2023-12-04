{ pkgs, ... }:

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
      nd = "nix develop --max-jobs auto --builders 'cores = 0'";
    };
    functions = {
      fish_user_key_bindings = { body = "bind -k nul accept-autosuggestion"; };
      fish_greeting = { body = ""; };
      last_history_item = { body = "echo -- $history[1]"; };
    };
    shellInit = ''
      abbr --add !! --position anywhere --function last_history_item
    '';
    plugins = [{
      name = "done";
      src = pkgs.fetchFromGitHub {
        owner = "franciscolourenco";
        repo = "done";
        rev = "fbea3f682f9f32d957946490436e9dde8a67c367";
        sha256 = "sha256-BGHfwKoMfOZUsa05kEt8W2luc1aC3Su/OyaGmcb4UiI=";
      };
    }];
  };
}
