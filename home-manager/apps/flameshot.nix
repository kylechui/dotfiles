{
  services.flameshot = {
    enable = true;
    settings = {
      General = {
        disabledTrayIcon = true;
        showDesktopNotification = false;
        showHelp = false;
        showStartupLaunchMessage = false;
        # Use `flameshot config` to choose the buttons first, and export to a file
        buttons =
          "@Variant(000x7f000vQList<int>0000	0000000x1000x2000x3000x4000x5000x12000xf000a)";
      };
    };
  };
}
