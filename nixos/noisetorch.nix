{ pkgs, ... }:

{
  programs.noisetorch.enable = true;
  systemd.services.noisetorch = {
    description = "Noise suppression for PulseAudio";
    wantedBy = [ "multi-user.target" ];
    after = [ "pulseaudio.service" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.noisetorch}/bin/noisetorch -i";
      Restart = "on-failure";
    };
  };
}
