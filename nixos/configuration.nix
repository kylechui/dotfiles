# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./acpid.nix
    ./fcitx5.nix
    ./keyd.nix
    ./logiops.nix
    ./noisetorch.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.loader.grub.configurationLimit = 100;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  ### Enable some default programs
  networking.networkmanager.enable = true;
  programs.fish.enable = true;
  programs.dconf.enable = true;
  programs.steam.enable = true;
  # Storage optimization settings
  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
  # Prevent (D)OOM
  services.earlyoom = {
    enable = true;
    freeSwapThreshold = 2;
    freeMemThreshold = 2;
    extraArgs = [
      "-g"
      "--avoid '^(X|i3.*|wezterm|picom)$'"
      "--prefer '^(electron|libreoffice|gimp)$'"
    ];
  };

  # Enable flakes by default
  nix.package = pkgs.nix;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

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

  environment.systemPackages = [ pkgs.xorg.xf86videointel ];
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";
    autoRepeatInterval = 40;
    autoRepeatDelay = 280;
    videoDrivers = [ "intel" ];
    libinput = {
      enable = true;
      touchpad = {
        naturalScrolling = true;
        disableWhileTyping = true;
      };
    };
    displayManager = {
      # Disable screen sleep timeout
      xserverArgs = [
        "-s"
        "0"
      ];
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
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 30;
    };
  };
  services.thermald.enable = true;

  # Bluetooth management
  services.blueman.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kylec = {
    isNormalUser = true;
    description = "Kyle Chui";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.bash;
    packages = [ ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [ "electron-25.9.0" ];
  hardware.bluetooth.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
  };

  environment.wordlist = {
    enable = true;
    lists = {
      WORDLIST = [ "${pkgs.scowl}/share/dict/words.txt" ];
    };
  };

  zramSwap = {
    enable = true;
    memoryPercent = 50;
  };

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
