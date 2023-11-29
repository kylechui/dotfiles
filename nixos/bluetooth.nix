{ pkgs, ... }:

{
  systemd.services.toggle_bluetooth = {
    enable = true;
    description = "Toggle bluetooth on lid open/close";
    wantedBy = [ "multi-user.target" ];
    script = ''
      #!/bin/bash
      while true; do
          if grep -q "open" /proc/acpi/button/lid/LID0/state; then
            ${pkgs.bluez}/bin/bluetoothctl power on
          else
            ${pkgs.bluez}/bin/bluetoothctl power off
          fi
          sleep 5
      done
    '';
    serviceConfig = {
      Type = "simple";
      Restart = "always";
    };
  };
}
