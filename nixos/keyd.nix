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

}
