{
  programs.noisetorch.enable = true;
  # systemd.services.noisetorch = {
  #   description = "Noise suppression for PulseAudio";
  #   wantedBy = [ "default.target" ];
  #   after = [ "graphical.target" ];
  #   requires = [ "graphical.target" ];
  #   serviceConfig = {
  #     Type = "simple";
  #     ExecStart = "/run/wrappers/bin/noisetorch -i";
  #     Restart = "on-failure";
  #   };
  # };
}
