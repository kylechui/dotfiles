{ pkgs, ... }:

{
  programs.noisetorch.enable = true;
  # https://github.com/noisetorch/NoiseTorch/wiki/Start-automatically-with-Systemd
  systemd.user.services.noisetorch = {
    description = "Noisetorch Noise Cancelling";
    wantedBy = [ "default.target" ];
    after = [
      "pipewire.service"
      "pipewire-pulse.service"
      "sys-devices-pci0000:00-0000:00:1f.3-skl_hda_dsp_generic-sound-card0-controlC0.device"
    ];
    requires = [
      "sys-devices-pci0000:00-0000:00:1f.3-skl_hda_dsp_generic-sound-card0-controlC0.device"
    ];
    serviceConfig = {
      Type = "simple";
      RemainAfterExit = true;
      ExecStart = "${pkgs.noisetorch}/bin/noisetorch -i -s alsa_input.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__hw_sofhdadsp__source -t 85";
      ExecStop = "${pkgs.noisetorch}/bin/noisetorch -u";
      Restart = "on-failure";
      RestartSec = 3;
    };
  };
}
