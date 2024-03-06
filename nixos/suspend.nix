{ pkgs, ... }:

let
  pname = "systemd-sleep-hook";
  systemd-sleep-hook = pkgs.python3Packages.buildPythonPackage {
    inherit pname;
    version = "0.0.1";
    format = "pyproject";
    nativeBuildInputs = [ pkgs.python311Packages.setuptools ];
    propagatedBuildInputs = [
      pkgs.python311Packages.dbus-python
      pkgs.python311Packages.pygobject3
    ];
    src = pkgs.fetchFromGitHub {
      owner = "jishnusen";
      repo = pname;
      rev = "da6190a9103970f5b6874890662c9f82934e5c8c";
      hash = "sha256-0DnyFUBeXElsT2ndjDPM5J4yG0ngUeAOyqt1o5UGugE=";
    };
  };
in
{
  environment.systemPackages = [ systemd-sleep-hook ];
  systemd.user.services."systemd-sleep-hook" = {
    description = "Toggle radios on suspend/resume";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = ''
        ${systemd-sleep-hook}/bin/systemd-sleep-hook -s '${pkgs.util-linux}/bin/rfkill block all' -r '${pkgs.util-linux}/bin/rfkill unblock all'
      '';
    };
  };
}
