{ pkgs, ... }:

pkgs.st.overrideAttrs (oldAttrs: {
  buildInputs = oldAttrs.buildInputs ++ [ pkgs.harfbuzz ];
  src = fetchTarball {
    url = "https://dl.suckless.org/st/st-0.8.5.tar.gz";
    sha256 = "sha256:0iy7sj40m5x7wr4qkicijckk3cb0h9815mzacfjb3xrlrvpx6hm5";
  };
  patches = oldAttrs.patches ++ [
    (pkgs.fetchpatch {
      url = "https://st.suckless.org/patches/scrollback/st-scrollback-0.8.5.diff";
      hash = "sha256-ZZAbrWyIaYRtw+nqvXKw8eXRWf0beGNJgoupRKsr2lc=";
    })
    (pkgs.fetchpatch {
      url = "https://st.suckless.org/patches/scrollback/st-scrollback-reflow-0.8.5.diff";
      hash = "sha256-GZq1DZl54NwC169tEOskqcIqMKjBCgCSHYXTKddxzFg=";
    })
    (pkgs.fetchpatch {
      url = "https://st.suckless.org/patches/scrollback/st-scrollback-mouse-20220127-2c5edf2.diff";
      hash = "sha256-CuNJ5FdKmAtEjwbgKeBKPJTdEfJvIdmeSAphbz0u3Uk=";
    })
    (pkgs.fetchpatch {
      url = "https://st.suckless.org/patches/scrollback/st-scrollback-mouse-altscreen-20220127-2c5edf2.diff";
      hash = "sha256-8oVLgbsYCfMhNEOGadb5DFajdDKPxwgf3P/4vOXfUFo=";
    })
    (pkgs.fetchpatch {
      url = "https://st.suckless.org/patches/ligatures/0.9/st-ligatures-20240105-0.9.diff";
      hash = "sha256-lMl4cg13inc8D1eH2rfbZTH+8hRLwlDLPq3+UqQPtzo=";
    })
    (pkgs.fetchpatch {
      url = "https://st.suckless.org/patches/xresources-with-reload-signal/st-xresources-signal-reloading-20220407-ef05519.diff";
      hash = "sha256-og6cJaMfn7zHfQ0xt6NKhuDNY5VK2CjzqJDJYsT5lrk=";
    })
    ./st-support-wide-glyphs.diff
    ./st-keymaps.diff
  ];
})
