{ pkgs, ... }:

{
  services.acpid = {
    enable = true;
    lidEventCommands = ''
      #!${pkgs.bash}/bin/bash
      # Disable Wi-Fi/Bluetooth when laptop lid is closed
      if grep -q "open" /proc/acpi/button/lid/LID0/state; then
        ${pkgs.bluez}/bin/bluetoothctl power on
        ${pkgs.networkmanager}/bin/nmcli radio wifi on
      else
        ${pkgs.bluez}/bin/bluetoothctl power off
        ${pkgs.networkmanager}/bin/nmcli radio wifi off
      fi
    '';
  };
}
