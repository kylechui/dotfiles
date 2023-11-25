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

  imports = [ # Include application-specific configuration
    ./apps/autorandr.nix
    ./apps/chromium.nix
    ./apps/dunst.nix
    ./apps/firefox.nix
    ./apps/fish.nix
    ./apps/flameshot.nix
    ./apps/fzf.nix
    ./apps/i3.nix
    ./apps/neovim.nix
    ./apps/polybar.nix
    ./apps/rofi.nix
    ./apps/vscodium.nix
    ./apps/wezterm.nix
    ./apps/zathura.nix
    ./apps/zoxide.nix
  ];

  services.network-manager-applet.enable = true;
  services.blueman-applet.enable = true;
  services.betterlockscreen.enable = true;
  programs.git = {
    enable = true;
    userName = "Kyle Chui";
    userEmail = "kyle.chui+github@pm.me";
  };
  programs.opam.enable = true;
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
    # Social
    element-desktop
    signal-desktop
    discord
    zoom-us
    # Other apps
    spotify
    unstable.localsend
    pavucontrol
    unstable.obsidian
    libreoffice-qt
    screenkey
    simplescreenrecorder

    nerdfonts
    xfce.thunar
    nodePackages.vscode-langservers-extracted
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
    # Java
    jdt-language-server
    # JavaScript/TypeScript
    nodejs
    typescript
    nodePackages.typescript-language-server
    unstable.prettierd
    # OCaml
    ocamlformat
    ocamlPackages.ocaml-lsp
    # Haskell
    haskell-language-server
    stylish-haskell
    # Nix
    unstable.nil
    nixfmt
    # Coq
    coqPackages.coq-lsp
    # Lua
    sumneko-lua-language-server
    stylua
    selene
    # LaTeX
    python311Packages.pygments # For using the `minted` package
    texlab
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.05";
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
