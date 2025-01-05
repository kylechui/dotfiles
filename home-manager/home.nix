{ pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "kylec";
  home.homeDirectory = "/home/kylec";
  # Necessary for some bug related to rendering manpage
  manual.manpages.enable = false;

  home.pointerCursor = {
    gtk.enable = true;
    name = "Dracula-cursors";
    size = 16;
    package = pkgs.dracula-theme;
  };

  xresources.extraConfig = ''
    *.font: IosevkaTerm Nerd Font:size=14
    ${builtins.readFile (
      builtins.fetchurl {
        url = "https://raw.githubusercontent.com/miikanissi/modus-themes.nvim/master/extras/xresources/modus_operandi.Xresources";
        sha256 = "sha256:1blr83mfkyqbcwg96fzp5lc098v63y8q1fl39swidkcv87jcnmsi";
      }
    )}
  '';

  imports = [
    # Include basic application-specific configuration
    ./apps/autorandr.nix
    ./apps/bat.nix
    ./apps/chromium.nix
    ./apps/dunst.nix
    ./apps/firefox.nix
    ./apps/fish.nix
    ./apps/flameshot.nix
    ./apps/fzf.nix
    ./apps/git.nix
    ./apps/i3.nix
    # ./apps/neovim.nix
    ./apps/polybar.nix
    ./apps/rofi.nix
    ./apps/tmux.nix
    ./apps/vscodium.nix
    ./apps/zoxide.nix
    # These apps come with other files, so they are in their own directories
    ./apps/zathura/zathura.nix
  ];

  services.picom.enable = true;
  services.playerctld.enable = true;

  programs.btop = {
    enable = true;
    settings = {
      vim_keys = true;
      proc_gradient = false;
    };
  };
  programs.nix-index = {
    enable = true;
    enableFishIntegration = true;
  };

  home.packages =
    let
      st = (import ./apps/st/st.nix { inherit pkgs; });
    in
    # iosevka-term = (
    #   pkgs.iosevka.override {
    #     set = "Term";
    #     privateBuildPlan = {
    #       family = "Iosevka Term";
    #     };
    #   }
    # );
    [
      st
      # iosevka-term
    ]
    ++ (with pkgs; [
      # CLI Utilities
      unstable.neovim
      thermald
      playerctl
      gdb
      zip
      unzip
      xclip
      ripgrep
      arandr
      tree
      pandoc
      libnotify
      sshfs
      jq
      yq
      tokei
      glxinfo
      pciutils
      sysstat
      nixpkgs-review
      pkg-config
      fontconfig
      texliveFull
      # Social
      element-desktop
      unstable.signal-desktop
      unstable.discord
      zoom-us
      # Other apps
      spotify
      pavucontrol
      obsidian
      libreoffice-qt
      screenkey
      simplescreenrecorder
      xfce.thunar
      anki

      # Fonts
      sarasa-gothic
      unstable.nerd-fonts.symbols-only
      unstable.nerd-fonts.iosevka-term
      iosevka-bin

      vscode-langservers-extracted
      # Shell
      shellcheck
      nodePackages.bash-language-server
      # C/C++
      cmake
      gnumake
      gcc
      clang-tools
      # Python
      python311
      unstable.ruff
      mypy
      pyright
      # JavaScript/TypeScript
      nodejs
      typescript
      nodePackages.typescript-language-server
      unstable.prettierd
      # OCaml
      ocamlformat
      ocamlPackages.ocaml-lsp
      dune_3
      # Nix
      unstable.nixd
      unstable.nixfmt-rfc-style
      # Lua
      sumneko-lua-language-server
      stylua
      selene
      # LaTeX
      python311Packages.pygments # For using the `minted` package
      texlab
      # Markdown/Obsidian
      unstable.markdown-oxide
    ]);

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.11";
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
