{ pkgs, ... }:

{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -U fish_key_bindings fish_vi_key_bindings 
      set -U fish_vi_force_cursor 1
      set -U fish_cursor_default block
      set -U fish_cursor_visual block
      set -U fish_cursor_insert line
      set -U fish_cursor_replace underscore
      set -U fish_cursor_replace_one underscore
      # Set the cursor shape in external shells/REPLs
      set -U fish_cursor_external line
      # Set manpage search color
      set -U man_standout -b 938aa9 1f1f28
      # Increase `done` notification persistence length
      set -U __done_notification_duration 10000
    '';
    shellAliases = {
      def = "get_definition";
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
      glo = "git log --oneline";
      gm = "git mergetool";
      gf = "git fetch";
      gst = "git status";
    };
    functions = {
      get_definition = {
        description = "Retrieves the Merriam-Webster definition of a word";
        body = ''
          ${pkgs.curl}/bin/curl --silent "https://www.merriam-webster.com/dictionary/$argv[1]" \
          | ${pkgs.gnugrep}/bin/grep '<span class="dtText">' \
          | ${pkgs.gnused}/bin/sed --regexp-extended "s/<[^<>]*>//g" \
          | ${pkgs.gnused}/bin/sed --regexp-extended "s/^ *: (.*)/\u\1/" \
          | ${pkgs.gnugrep}/bin/grep --invert-match "^\$" \
          | ${pkgs.coreutils}/bin/cat --number
        '';
      };
      find_git_repository = {
        description = "Find the root of the git repository";
        body = ''
          ${pkgs.git}/bin/git rev-parse --git-common-dir 2>/dev/null
        '';
      };
      in_bare_repo = {
        description = "Check if currently inside git bare repository or worktree";
        body = ''
          set -l in_bare_root (${pkgs.git}/bin/git rev-parse --is-bare-repository)
          if test "$in_bare_root" = "true"
              return 0
          end
          set -l git_dir (${pkgs.git}/bin/git rev-parse --path-format=absolute --git-dir)
          set -l git_common_dir (${pkgs.git}/bin/git rev-parse --path-format=absolute --git-common-dir)
          return (test "$git_dir" != "$git_common_dir")
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
          set -l matches "$(get_branches | ${pkgs.gnugrep}/bin/grep "$name")"
          if echo "$matches" | ${pkgs.gnugrep}/bin/grep --quiet "^$name\$"
            set -f branch "$name"
          else
            set -f branch "$(echo "$matches" \
            | ${pkgs.fzf}/bin/fzf --query="$name" \
                                  --select-1 \
                                  --height=40% \
                                  --reverse)"
          end

          if test -z $branch
            echo "No branch selected"
            return 1
          end

          if in_bare_repo
            cd "$(find_git_repository)/$branch"
          else
            git checkout "$branch"
          end
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
          bind -M insert \e\[Z up-line # This is <S-Tab>
          bind -M insert \ca beginning-of-line # This is <C-A>
          bind -M insert \ce end-of-line # This is <C-E>
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

          echo -ns '  '
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
          url = "https://raw.githubusercontent.com/miikanissi/modus-themes.nvim/983d898ae82df7c87a2377292eef860c5aa16c81/extras/fish/modus_operandi.fish";
          sha256 = "sha256:0i8wkv46a3rd6pyai1lfmnp2cj6yf20rnnp1hl515j3mp3gzj1h8";
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
