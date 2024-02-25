{ pkgs, ... }:

{
  services.acpid = {
    enable = true;
    lidEventCommands = ''
      #!${pkgs.bash}/bin/bash
      display_active() {
        num_active_displays=$(${pkgs.xorg.xrandr}/bin/xrandr --listactivemonitors \
        | ${pkgs.coreutils}/bin/head -n 1 \
        | ${pkgs.coreutils}/bin/cut -d ' ' -f 2)
        [ "$num_active_displays" != "0" ]
      }
      if display_active; then
        ${pkgs.bluez}/bin/bluetoothctl power on
        ${pkgs.networkmanager}/bin/nmcli radio wifi on
      else
        ${pkgs.bluez}/bin/bluetoothctl power off
        ${pkgs.networkmanager}/bin/nmcli radio wifi off
      fi
    '';
  };
}
