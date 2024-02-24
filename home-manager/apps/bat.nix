{ pkgs, ... }:

{
  programs.bat = {
    enable = true;
    config.theme = "kanagawa";
    themes = {
      kanagawa = {
        src = pkgs.fetchFromGitHub {
          owner = "kylechui";
          repo = "kanagawa.nvim";
          rev = "a8b360fa5fb93dc4733da01408ca1806bd227e86";
          sha256 = "sha256-9peOxX4UqeqtZmNiUaNs/3uH8rsqIA7AoK1DCdVOeSw=";
        };
        file = "extras/kanagawa.tmTheme";
      };
    };
  };
}
