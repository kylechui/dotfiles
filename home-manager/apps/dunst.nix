{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        width = 400;
        height = 300;
        offset = 30;
      };
      skip-rule = {
        appname = "blueman";
        skip_display = true;
      };
    };
  };
}
