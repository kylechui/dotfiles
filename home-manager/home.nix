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
    ./apps/ncspot.nix
    ./apps/neovim.nix
    ./apps/rofi.nix
    ./apps/tmux.nix
    ./apps/vscodium.nix
    ./apps/zoxide.nix
    # These apps come with other files, so they are in their own directories
    ./apps/polybar/polybar.nix
    ./apps/wezterm/wezterm.nix
    ./apps/zathura/zathura.nix
  ];

  services.betterlockscreen.enable = true;
  services.picom.enable = true;

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

  programs.texlive = {
    enable = true;
    extraPackages = tpkgs: { inherit (tpkgs) scheme-full; };
  };

  home.packages = with pkgs; [
    # CLI Utilities
    zip
    unzip
    xclip
    ripgrep
    arandr
    tree
    pandoc
    libnotify
    sshfs
    fd
    jq
    yq
    glxinfo
    pciutils
    sysstat
    nixpkgs-review
    # Social
    element-desktop
    signal-desktop
    discord
    zoom-us
    # Other apps
    spotify
    unstable.localsend
    pavucontrol
    obsidian
    libreoffice-qt
    screenkey
    simplescreenrecorder

    nerdfonts
    iosevka
    sarasa-gothic
    xfce.thunar
    # Shell
    shellcheck
    # C/C++
    cmake
    gnumake
    gcc
    clang-tools
    # Python
    python311
    black
    mypy
    nodePackages.pyright
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
    unstable.nil
    nixfmt
    # Lua
    sumneko-lua-language-server
    stylua
    selene
    # LaTeX
    python311Packages.pygments # For using the `minted` package
    texlab
    # Markdown/Obsidian
    (pkgs.rustPlatform.buildRustPackage {
      pname = "markdown-oxide";
      version = "0.0.3";
      src = pkgs.fetchFromGitHub {
        owner = "Feel-ix-343";
        repo = "markdown-oxide";
        rev = "fc710358651bc12f4f364295e2aa91215d458560";
        sha256 = "sha256-vDSqWMVCQ/SVv/n8C7blLL7Anu94UDILuL0s80ouU+0=";
      };
      cargoLock = {
        lockFile = builtins.fetchurl {
          url = "https://raw.githubusercontent.com/Feel-ix-343/markdown-oxide/main/Cargo.lock";
          sha256 = "sha256:1z3g00vjcy5jha9n52f7sx9im6n42ay45wckvqil1x0h6ciw4vim";
        };
        outputHashes = {
          "tower-lsp-0.20.0" = "sha256-QRP1LpyI52KyvVfbBG95LMpmI8St1cgf781v3oyC3S4=";
        };
      };
    })
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
