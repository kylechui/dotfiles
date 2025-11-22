{ pkgs, ... }:

pkgs.st.overrideAttrs (oldAttrs: {
  buildInputs = oldAttrs.buildInputs ++ [ pkgs.harfbuzz ];
  src = fetchTarball {
    url = "https://dl.suckless.org/st/st-0.9.3.tar.gz";
    sha256 = "sha256:1c30c2dxw6y627dhas1gi68ivz9zcfqz9xy0rvz0jmlclfslkgay";
  };
  patches = oldAttrs.patches ++ [
    (pkgs.fetchpatch {
      url = "https://st.suckless.org/patches/xresources-with-reload-signal/st-xresources-signal-reloading-20220407-ef05519.diff";
      hash = "sha256-og6cJaMfn7zHfQ0xt6NKhuDNY5VK2CjzqJDJYsT5lrk=";
    })
    ./001-st-0.9.3-scrollback.patch
    ./002-st-0.9.3-scrollback-reflow.patch
    ./003-st-0.9.3-scrollback-mouse.patch
    ./004-st-0.9.3-scrollback-altscreen.patch
    ./005-st-0.9.3-boxdraw.patch
    ./006-st-0.9.3-wideglyphs.patch
    ./007-st-0.9.3-clickurl.patch
    ./008-st-0.9.3-ligatures.patch
    ./009-st-0.9.3-keymaps.patch
  ];
})
