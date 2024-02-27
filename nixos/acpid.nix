{ pkgs, ... }:

{
  services.acpid = {
    enable = true;
    lidEventCommands = ''
      #!${pkgs.bash}/bin/bash
      lid_closed=$(${pkgs.coreutils}/bin/cat /proc/acpi/button/lid/LID0/state | ${pkgs.gnugrep}/bin/grep -c 'closed')
      connected_monitors=$(${pkgs.coreutils}/bin/cat /sys/class/drm/card0-*/status | ${pkgs.gnugrep}/bin/grep -cx 'connected')
      if [ $lid_closed -ne 1 ] || [ $connected_monitors -ne 1 ]; then
        ${pkgs.bluez}/bin/bluetoothctl power on
        ${pkgs.networkmanager}/bin/nmcli radio wifi on
      else
        ${pkgs.bluez}/bin/bluetoothctl power off
        ${pkgs.networkmanager}/bin/nmcli radio wifi off
      fi
    '';
  };
}
