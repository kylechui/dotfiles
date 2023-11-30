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
          "@Variant(\\0\\0\\0\\x7f\\0\\0\\0\\vQList<int>\\0\\0\\0\\0\\t\\0\\0\\0\\0\\0\\0\\0\\x1\\0\\0\\0\\x2\\0\\0\\0\\x3\\0\\0\\0\\x4\\0\\0\\0\\x5\\0\\0\\0\\x12\\0\\0\\0\\xf\\0\\0\\0\\a)";
      };
    };
  };
}
