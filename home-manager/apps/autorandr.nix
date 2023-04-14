{ config, pkgs, ... }:

{
  services.autorandr.enable = true;
  programs.autorandr = {
    enable = true;
    profiles = {
      # mobile = {
      #   fingerprint = {
      #     eDP1 = "";
      #   };
      #   config = {
      #     eDP1.enable = true;
      #   };
      # };
      docked = {
        fingerprint = {
          eDP1 = "";
          DP1 = "";
        };
        config = {
          eDP1.enable = false;
          DP1 = {
            enable = true;
            # crtc = 0;
            primary = true;
            position = "0x0";
            mode = "2560x1440";
            # gamma = "1.0:0.909:0.833";
            rate = "72.00";
            # rotate = "left";
          };
        };
      };
    };
  };
}
