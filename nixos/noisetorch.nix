{
  programs.noisetorch.enable = true;
  # NOTE: Currently enabled in i3 xdg-autostart
  /* systemd.services.noisetorch = {
       description = "Noise suppression for PulseAudio";
       wantedBy = [ "default.target" ];
       after = [ "graphical.target" ];
       requires = [ "graphical.target" ];
       serviceConfig = {
         Type = "simple";
         ExecStart = "/run/wrappers/bin/noisetorch -i";
         Restart = "on-failure";
       };
     };
  */
}
