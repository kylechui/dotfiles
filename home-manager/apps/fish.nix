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
    plugins = [
      {
        name = "done";
        src = pkgs.fetchFromGitHub {
          owner = "franciscolourenco";
          repo = "done";
          rev = "fbea3f682f9f32d957946490436e9dde8a67c367";
          sha256 = "sha256-BGHfwKoMfOZUsa05kEt8W2luc1aC3Su/OyaGmcb4UiI=";
        };
      }
      {
        name = "kanagawa";
        src = pkgs.stdenv.mkDerivation {
          name = "kanagawa-fish";
          src = pkgs.fetchFromGitHub {
            owner = "rebelot";
            repo = "kanagawa.nvim";
            rev = "c19b9023842697ec92caf72cd3599f7dd7be4456";
            sha256 = "sha256-pbLcomZHzC2JGKF4oII6AAm5q/dzQtNfFAZVNX74nB8=";
          };
          buildPhase = ''
            mkdir -p $out
            mv extras/kanagawa.fish $out/init.fish
          '';
        };
      }
    ];
  };
}
