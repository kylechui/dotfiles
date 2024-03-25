{ pkgs, ... }:

pkgs.tabbed.overrideAttrs (oldAttrs: {
  patches = oldAttrs.patches ++ [
    (pkgs.fetchpatch {
      url = "https://tools.suckless.org/tabbed/patches/autohide/tabbed-autohide-20201222-dabf6a2.diff";
      hash = "sha256-VjlM9X/24pFb8/Xh9/ktmKqy7tskbKk+K+G2/bxWxKU=";
    })
    (pkgs.fetchpatch {
      url = "https://tools.suckless.org/tabbed/patches/cwd/tabbed-cwd-20230128-41e2b8f.diff";
      hash = "sha256-4Qg3lUOIisuEP/h3jK1nTLnr5tL09MGxPc93qxoBKAI=";
    })
    (pkgs.fetchpatch {
      url = "https://tools.suckless.org/tabbed/patches/drag/tabbed-drag-20230128-41e2b8f.diff";
      hash = "sha256-zJKQpPhiCBVXf6H3Cjoh2GO4mnGNxzl8J+P681FZP64=";
    })
    ./tabbed-keymaps.diff
    ./tabbed-theme.diff
    ./tabbed-relative-position.diff
  ];
})
