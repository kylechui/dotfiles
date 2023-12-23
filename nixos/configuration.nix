# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./bluetooth.nix
    ./wifi.nix
    ./keyd.nix
    ./logiops.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.loader.grub.configurationLimit = 20;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  ### Enable some default programs
  networking.networkmanager.enable = true;
  programs.fish.enable = true;
  programs.noisetorch.enable = true;
  programs.dconf.enable = true;
  programs.steam.enable = true;
  nix.settings.auto-optimise-store = true;

  # Enable flakes by default
  nix.package = pkgs.nix;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5 = {
      # Once home-manager has a module for fcitx5, this can be removed
      # The config files are stored in /etc/xdg/fcitx5, NOT ~/.config/fcitx5
      ignoreUserConfig = true;
      addons = [
        pkgs.fcitx5-chinese-addons
        pkgs.fcitx5-rime
        pkgs.fcitx5-gtk
        pkgs.fcitx5-nord
      ];
      settings = {
        addons = { classicui.globalSection.Theme = "Nord-Dark"; };
        globalOptions = { "Hotkey/TriggerKeys" = { "0" = "Alt+space"; }; };
        inputMethod = {
          "Groups/0" = {
            Name = "Default";
            "Default Layout" = "us";
            DefaultIM = "keyboard-us";
          };
          "Groups/0/Items/0" = {
            Name = "keyboard-us";
            Layout = "";
          };
          "Groups/0/Items/1" = {
            Name = "pinyin";
            Layout = "";
          };
          GroupOrder = { "0" = "Default"; };
        };
      };
    };
  };

  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";
    autoRepeatInterval = 40;
    autoRepeatDelay = 280;
    libinput = {
      enable = true;
      touchpad = {
        naturalScrolling = true;
        disableWhileTyping = true;
      };
    };
    windowManager.i3 = {
      enable = true;
      extraPackages = [ ];
    };
  };

  services.autorandr = {
    enable = true;
    defaultTarget = "mobile";
  };

  # Power management
  services.tlp.enable = true;

  # Bluetooth management
  services.blueman.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kylec = {
    isNormalUser = true;
    description = "Kyle Chui";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    shell = pkgs.bash;
    packages = [ ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [ "electron-25.9.0" ];
  # Enable Bluetooth
  hardware.bluetooth.enable = true;
  hardware.pulseaudio.enable = true;
  virtualisation.docker.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.wordlist.enable = true;
  environment.systemPackages = with pkgs; [ scowl ];

  services.gvfs.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
