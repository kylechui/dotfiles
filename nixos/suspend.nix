{ pkgs, ... }:

let
  pname = "systemd-sleep-hook";
  systemd-sleep-hook = pkgs.python3Packages.buildPythonPackage {
    inherit pname;
    version = "0.0.3";
    format = "pyproject";
    nativeBuildInputs = [ pkgs.python311Packages.setuptools ];
    propagatedBuildInputs = [
      pkgs.python311Packages.dbus-python
      pkgs.python311Packages.pygobject3
    ];
    src = pkgs.fetchFromGitHub {
      owner = "jishnusen";
      repo = pname;
      rev = "732c20624b6387a8758091105a425f9d019c3045";
      hash = "sha256-QJF9Ud/dizCdo9Y6nZXWQiVHpVuzRdxCLxv+UniAmRo=";
    };
  };
in
{
  environment.systemPackages = [ systemd-sleep-hook ];
  systemd.user.services."systemd-sleep-hook" = {
    description = "Toggle radios on suspend/resume";
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = ''
        ${systemd-sleep-hook}/bin/systemd-sleep-hook -s '${pkgs.util-linux}/bin/rfkill block all' -r '${pkgs.util-linux}/bin/rfkill unblock all'
      '';
      Restart = "always";
      RestartSec = 1;
    };
  };
  systemd.user.services."xss-lock" = {
    description = "xss-lock, session locker service";
    wantedBy = [ "graphical-session.target" ];
    after = [ "graphical-session-pre.target" ];
    partOf = [ "graphical-session.target" ];

    serviceConfig = {
      Type = "simple";
      ExecStart = ''
        ${pkgs.xss-lock}/bin/xss-lock -s ''${XDG_SESSION_ID} -- ${pkgs.betterlockscreen}/bin/betterlockscreen --lock --quiet
      '';
    };
  };
}
