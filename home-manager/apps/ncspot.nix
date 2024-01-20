{ pkgs, ... }:

{
  programs.ncspot = {
    enable = true;
    package = pkgs.unstable.ncspot;
    settings = {
      backend = "pulseaudio";
      use_nerdfont = true;
      flip_status_indicators = true;
    };
  };
}
