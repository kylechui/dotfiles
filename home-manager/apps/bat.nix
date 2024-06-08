{ pkgs, ... }:

{
  programs.bat = {
    enable = true;
    config.theme = "modus_operandi";
    themes = {
      modus_operandi = {
        src = pkgs.fetchFromGitHub {
          owner = "miikanissi";
          repo = "modus-themes.nvim";
          rev = "181dc38ddbcf9ad94d454cb06b13c859d4ff28d1";
          sha256 = "sha256-yLcNfDUwS0neA9N6LCxTtLtVAjzdZfXIJ9OVnOM42WA=";
        };
        file = "extras/bat/modus_operandi.tmTheme";
      };
    };
  };
}
