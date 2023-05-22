{
  services.keyd = {
    enable = true;
    ids = [ "*" ];
    settings = {
      main = {
        capslock = "overload(meta, esc)";
        esc = "capslock";
      };
    };
  };

  systemd.services.keyd = {
    wantedBy = [ "sleep.target" ];
    after = [
      "systemd-suspend.service"
      "systemd-hybrid-sleep.service"
      "systemd-hibernate.service"
    ];
  };
}
