{ pkgs, ... }:

{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -g fish_key_bindings fish_vi_key_bindings 
      set -g fish_vi_force_cursor 1
      set -g fish_cursor_default block
      set -g fish_cursor_visual block
      set -g fish_cursor_insert line
      set -g fish_cursor_replace underscore
      set -g fish_cursor_replace_one underscore
      # Set the cursor shape in external shells/REPLs
      set -g fish_cursor_external line
      # Set manpage search color
      set -g man_standout -b 938aa9 1f1f28
      # Increase `done` notification persistence length
      set -U __done_notification_duration 10000
    '';
    shellAliases = {
      ll = "ls -ahl";
      rm = "rm -I";
      gc = "git_checkout";
      gwa = "git_worktree_add";
      gwr = "git_worktree_remove";
      copy = "${pkgs.coreutils}/bin/tee (${pkgs.coreutils}/bin/tty) | ${pkgs.xclip}/bin/xclip -selection clipboard";
    };
    shellAbbrs = {
      e = "nvim";
      cat = "bat";
      nd = "nix develop";
      nf = "nix flake";
      gl = "git log";
      gm = "git mergetool";
      gf = "git fetch";
      gst = "git status";
    };
    functions = {
      find_git_repository = {
        description = "Find the root of the git repository";
        body = ''
          ${pkgs.git}/bin/git rev-parse --git-common-dir 2>/dev/null
        '';
      };
      branch_exists = {
        description = "Check if a branch exists";
        argumentNames = [ "branch" ];
        body = ''
          ${pkgs.git}/bin/git branch --all | ${pkgs.gnugrep}/bin/grep -q "$branch"
        '';
      };
      get_branches = {
        description = "List all branches in the current git repository";
        body = ''
          ${pkgs.git}/bin/git branch --all \
          | ${pkgs.gnused}/bin/sed -E "s/^.{2}//"
        '';
      };
      git_checkout = {
        description = "git checkout";
        argumentNames = [ "name" ];
        body = ''
          set -l original_dir (pwd)
          set -l branches (get_branches | ${pkgs.gnugrep}/bin/grep "$name")
          if test (count $branches) -eq 1
            set -f branch (echo $branches | head -n 1)
          else
            set -f branch (get_branches | ${pkgs.fzf}/bin/fzf --query="$name")
          end
          if test -z $branch
            echo "No branch selected" >&2
            cd $original_dir
            return 1
          end
          cd (find_git_repository)
          cd $branch
        '';
      };
      git_worktree_add = {
        description = "git worktree add";
        argumentNames = [ "branch" ];
        body = ''
          if test -z $branch
            set -f branch (
              ${pkgs.git}/bin/git ls-remote \
              | ${pkgs.gnugrep}/bin/grep "refs/heads" \
              | ${pkgs.gnused}/bin/sed -E "s/^.*\s*refs\/heads\/(.*)\$/\1/" \
              | ${pkgs.fzf}/bin/fzf
            )
            if test -z $branch
              echo "No branch selected" >&2
              return 1
            else
              ${pkgs.git}/bin/git fetch origin $branch:$branch
            end
          end
          cd (find_git_repository)
          if not branch_exists $branch
            ${pkgs.git}/bin/git branch $branch
          end
          ${pkgs.git}/bin/git push -u origin $branch
          if not test -d $branch
            ${pkgs.git}/bin/git worktree add $branch $branch
          end
          cd $branch
        '';
      };
      git_worktree_remove = {
        description = "git worktree remove";
        argumentNames = [ "branch" ];
        body = ''
          set -l original_dir (pwd)
          cd (find_git_repository)
          if test -z $branch
            set -f branch (get_branches | ${pkgs.fzf}/bin/fzf)
            if test -z $branch
              echo "No branch selected" >&2
              return 1
            end
          end
          if test -d $branch
            ${pkgs.git}/bin/git worktree remove $branch
          end
          if branch_exists $branch
            ${pkgs.git}/bin/git branch -D $branch
          end
          cd $original_dir
        '';
      };
      fish_user_key_bindings = {
        body = ''
          # Use `fish_key_reader` to figure out key sequences
          bind -M insert -k nul accept-autosuggestion # This is <C-Space>
          bind -M insert \b backward-kill-word # This is <C-BS>
        '';
      };
      fish_greeting = {
        body = "";
      };
      pretty_ms = {
        argumentNames = [
          "ms"
          "interval"
        ];
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

          echo -ns ' '
        '';
      };
      fish_mode_prompt = {
        body = ''
          switch $fish_bind_mode
            case default
              set_color --bold 7E9CD8
              echo '[N] '
            case insert
              set_color --bold 76946A
              echo '[I] '
            case replace replace_one
              set_color --bold FF9E64
              echo '[R] '
            case visual
              set_color --bold 957FB8
              echo '[V] '
            case '*'
              set_color --bold red
              echo '[?] '
          end
          set_color normal
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
      last_history_item = {
        body = "echo -- $history[1]";
      };
      multicd = {
        body = "string repeat -n (math (string length -- $argv[1]) - 1) ../";
      };
    };
    shellInit = ''
      abbr --add !! --position anywhere --function last_history_item
      abbr --add dotdot --regex '^\.\.+$' --position anywhere --function multicd
      source ${
        builtins.fetchurl {
          url = "https://raw.githubusercontent.com/rebelot/kanagawa.nvim/c19b9023842697ec92caf72cd3599f7dd7be4456/extras/kanagawa.fish";
          sha256 = "sha256:0smmy783j41294gda1mpq8bqdy7h7j69zhh2i0dgxdg4gxqm7i6s";
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
