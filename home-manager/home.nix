{ pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "kylec";
  home.homeDirectory = "/home/kylec";

  home.pointerCursor = {
    gtk.enable = true;
    name = "Dracula-cursors";
    size = 16;
    package = pkgs.dracula-theme;
  };

  imports =
    [ # Include application-specific configuration
      ./apps/autorandr.nix
      ./apps/flameshot.nix
      ./apps/i3.nix
      ./apps/polybar.nix
      ./apps/wezterm.nix
      ./apps/zathura.nix
      ./apps/zsh.nix
    ];

  programs.firefox.enable = true;
  programs.neovim.enable = true;
  programs.rofi.enable = true;
  programs.git.enable = true;
  programs.opam.enable = true;
  services.network-manager-applet.enable = true;
  services.blueman-applet.enable = true;

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.packages = with pkgs; [
    nerdfonts
    networkmanagerapplet

    wget
    spotify
    discord
    logiops
    arandr
    pavucontrol
    flameshot
    gnome.nautilus
    ripgrep
    xclip
    unzip
    signal-desktop
    element-desktop
    obsidian
    # Language support
    cargo
    gcc
    llvmPackages_9.libclang
    gnumake
    cmake
    python3
    typescript
    nodejs
    ocaml
    ghc
    haskell-language-server
    sumneko-lua-language-server
    stylua
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
