{ pkgs, ... }:

{
  home.file.".xprofile".text = ''
    ${pkgs.xcompmgr}/bin/xcompmgr &
  '';
}
