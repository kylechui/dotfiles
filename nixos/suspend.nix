{ pkgs, ... }:

{
  # This is considered a "hack" that uses systemd-sleep[1]; I should figure out
  # how to use inhibitor pattern[2] to make this work.
  # [1]: https://www.freedesktop.org/software/systemd/man/latest/systemd-sleep.html
  # [2]: https://systemd.io/INHIBITOR_LOCKS/
  environment.etc."systemd/system-sleep/suspend-toggle-radios.sh".source = pkgs.writeShellScript "suspend-toggle-radios.sh" ''
    if [ "$1" = "pre" ]; then
      ${pkgs.util-linux}/bin/rfkill block bluetooth
      ${pkgs.util-linux}/bin/rfkill block wifi
    elif [ "$1" = "post" ]; then
      ${pkgs.util-linux}/bin/rfkill unblock bluetooth
      ${pkgs.util-linux}/bin/rfkill unblock wifi
    fi
  '';
}
