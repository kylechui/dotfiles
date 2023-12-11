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
      source ${
        builtins.fetchurl {
          url =
            "https://raw.githubusercontent.com/rebelot/kanagawa.nvim/c19b9023842697ec92caf72cd3599f7dd7be4456/extras/kanagawa.fish";
          sha256 =
            "sha256:0smmy783j41294gda1mpq8bqdy7h7j69zhh2i0dgxdg4gxqm7i6s";
        }
      }
    '';
    plugins = [{
      name = "done";
      src = pkgs.fishPlugins.done.src;
    }];
  };
}
