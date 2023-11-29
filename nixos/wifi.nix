{ pkgs, ... }:

{
  systemd.services.toggle_wifi = {
    enable = true;
    description = "Toggle wifi on lid open/close";
    wantedBy = [ "multi-user.target" ];
    script = ''
      #!/bin/bash
      while true; do
          if grep -q "open" /proc/acpi/button/lid/LID0/state; then
            ${pkgs.networkmanager}/bin/nmcli radio wifi on
          else
            ${pkgs.networkmanager}/bin/nmcli radio wifi off
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
