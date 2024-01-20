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
        "d" = "noop";
        "s" = "shuffle";
        "q" = "focus queue";
        "y" = "share selected";
        "Space" = "toggleplayback";
        "Ctrl+f" = "search";
        "Shift+j" = "move down 5";
        "Shift+k" = "move up 5";
        "Shift+q" = "quit";
      };
    };
  };
}
