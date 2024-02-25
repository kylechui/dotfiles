{ pkgs, ... }:

{
  programs.noisetorch.enable = true;
  # https://github.com/noisetorch/NoiseTorch/wiki/Start-automatically-with-Systemd
  systemd.services.noisetorch = {
    description = "Noisetorch Noise Cancelling";
    wantedBy = [ "multi-user.target" ];
    after = [
      "pipewire-pulse.service"
      "sys-devices-pci0000:00-0000:00:1f.3-skl_hda_dsp_generic-sound-card0-controlC0.device"
    ];
    requires = [
      "sys-devices-pci0000:00-0000:00:1f.3-skl_hda_dsp_generic-sound-card0-controlC0.device"
    ];
    serviceConfig = {
      Type = "simple";
      RemainAfterExit = true;
      ExecStart = "${pkgs.noisetorch}/bin/noisetorch -i -t 85";
      ExecStop = "${pkgs.noisetorch}/bin/noisetorch -u";
      Restart = "on-failure";
      RestartSec = 3;
      # `pipewire-pulse.service` runs as user
      User = "kylec";
    };
  };
}
