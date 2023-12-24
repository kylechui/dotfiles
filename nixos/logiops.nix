{ pkgs, ... }:

{
  # Create systemd service
  systemd.services.logiops = {
    enable = true;
    description = "An unofficial userspace driver for HID++ Logitech devices";
    wantedBy = [ "multi-user.target" ];
    script = ''
      while true; do
        if ${pkgs.bluez}/bin/bluetoothctl devices Connected | ${pkgs.gnugrep}/bin/grep -q "MX Master 3" ; then
          ${pkgs.logiops}/bin/logid
        fi
        sleep 5;
      done
    '';
    serviceConfig = {
      Restart = "always";
      Type = "simple";
    };
  };

  # Configuration for logiops
  environment.etc."logid.cfg".text = ''
    devices: ({
      name: "Wireless Mouse MX Master 3";
      smartshift: {
        on: true;
        threshold: 12;
      };
      hiresscroll: {
        hires: true;
        target: false;
      };
      dpi: 1200;
      buttons: ({
        cid: 0xc3;
        action = {
          type: "Gestures";
          gestures: ({
            direction: "Left";
            mode: "OnRelease";
            action = {
              type = "Keypress";
              keys: ["KEY_F15"];
            };
          }, {
            direction: "Right";
            mode: "OnRelease";
            action = {
              type = "Keypress";
              keys: ["KEY_F16"];
            };
          }, {
            direction: "Down";
            mode: "OnRelease";
            action = {
              type: "Keypress";
              keys: ["KEY_F17"];
            };
          }, {
            direction: "Up";
            mode: "OnRelease";
            action = {
              type: "Keypress";
              keys: ["KEY_F18"];
            };
          }, {
            direction: "None";
            mode: "OnRelease";
            action = {
              type = "Keypress";
              keys: ["KEY_PLAYPAUSE"];
            };
          });
        };
      }, {
        cid: 0xc4;
        action = {
          type: "Keypress";
          keys: ["KEY_F19"];
        };
      });
    });
  '';
}
