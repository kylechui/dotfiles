{ pkgs, ... }:

{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -g fish_key_bindings fish_vi_key_bindings 
      set -g fish_vi_force_cursor 1
      set -g fish_cursor_default block
      set -g fish_cursor_default block
      set -g fish_cursor_visual block
      set -g fish_cursor_insert line
      set -g fish_cursor_replace underscore
      set -g fish_cursor_replace_one underscore
    '';
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
      fish_user_key_bindings = {
        body = ''
          # Use `fish_key_reader` to figure out key sequences
          bind -M insert -k nul accept-autosuggestion # This is <C-Space>
          bind -M insert -k backspace backward-kill-word # This is <C-BS>
        '';
      };
      fish_greeting = { body = ""; };
      pretty_ms = {
        argumentNames = [ "ms" "interval" ];
        body = ''
          set -l interval_ms
          set -l scale 1

          switch $interval
            case s
              set interval_ms 1000
            case m
              set interval_ms 60000
            case h
              set interval_ms 3600000
              set scale 2
            end

          math -s$scale "$ms/$interval_ms"
          echo -ns $interval
        '';
      };
      cmd_duration = {
        body = ''
          [ -z "$CMD_DURATION" -o "$CMD_DURATION" -lt 100 ]
          and return

          if [ "$CMD_DURATION" -lt 5000 ]
            echo -ns $CMD_DURATION 'ms'
          else if [ "$CMD_DURATION" -lt 60000 ]
            pretty_ms $CMD_DURATION s
          else if [ "$CMD_DURATION" -lt 3600000 ]
            set_color $fish_color_error
            pretty_ms $CMD_DURATION m
          else
            set_color $fish_color_error
            pretty_ms $CMD_DURATION h
          end

          set_color $fish_color_normal
          set_color $fish_color_autosuggestion

          echo -ns ' ⮂ '
        '';
      };
      fish_right_prompt = {
        body = ''
          set -l theme_date_format "+%H:%M:%S "
          set -l theme_date_timezone "America/Los_Angeles"
          set_color $fish_color_autosuggestion

          # Show the duration of the last command
          cmd_duration
          # Show the current time
          date $theme_date_format

          set_color normal
        '';
      };
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
    plugins = [
      {
        name = "done";
        src = pkgs.fishPlugins.done.src;
      }
      {
        name = "colored-manpages";
        src = fetchGit {
          url = "https://github.com/decors/fish-colored-man";
          rev = "1ad8fff696d48c8bf173aa98f9dff39d7916de0e";
        };
      }
    ];
  };
}
