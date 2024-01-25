{
  services.keyd = {
    enable = true;
    keyboards.default.ids = [ "*" ];
    keyboards.default.settings = {
      main = {
        capslock = "overload(meta, esc)";
        esc = "capslock";
      };
    };
  };

  # Disable touchpad while typing
  # https://github.com/rvaiya/keyd/issues/375
  environment.etc."libinput/local-overrides.quirks".text = ''
    [keyd]
    MatchUdevType=keyboard
    MatchVendor=0xFAC
    AttrKeyboardIntegration=internal
  '';
}
