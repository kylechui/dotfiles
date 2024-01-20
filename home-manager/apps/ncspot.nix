{ pkgs, ... }:

{
  programs.ncspot = {
    enable = true;
    package = pkgs.unstable.ncspot;
    settings = {
      backend = "pulseaudio";
      flip_status_indicators = true;
      library_tabs = [ "tracks" "playlists" ];
      repeat = "playlist";
      use_nerdfont = true;
      keybindings = {
        "a" = "focus library";
        "q" = "focus queue";
        "Ctrl+f" = "focus search";
        "s" = "shuffle";
        "y" = "share selected";
        "Space" = "toggleplayback";
        "Ctrl+d" = "move down 20";
        "Ctrl+u" = "move up 20";
        "Shift+j" = "move down 5";
        "Shift+k" = "move up 5";
        "Shift+q" = "quit";
        "d" = "noop";
      };
    };
  };
}
