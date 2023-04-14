{
  programs.zathura = {
    enable = true;
    extraConfig = ''
      # TODO: Clean up zathurarc

      # settings
      set adjust-open width
      # set show-scrollbars true
      set first-page-column 2
      set window-title-basename true
      # set database sqlite
      set selection-clipboard clipboard


      # key bindings
      # map <C-[> abort # Still doesn't work :(
      map [normal]     <F11> toggle_fullscreen
      map [fullscreen] <F11> toggle_fullscreen
      map [normal]     <C-l> reload
      map [fullscreen] <C-l> reload

      map [normal]     e scroll down
      map [fullscreen] e scroll down
      map [normal]     <C-e> scroll down
      map [fullscreen] <C-e> scroll down
      map [normal]     y scroll up
      map [fullscreen] y scroll up
      map [normal]     <C-y> scroll up
      map [fullscreen] <C-y> scroll up
      map [normal]     r rotate rotate-ccw
      map [fullscreen] r rotate rotate-ccw

      map [normal]     <PageUp>   navigate previous
      map [fullscreen] <PageUp>   navigate previous
      map [normal]     <PageDown> navigate next
      map [fullscreen] <PageDown> navigate next

      map [normal]     <A-1> set "first-page-column 1:1"
      map [fullscreen] <A-1> set "first-page-column 1:1"
      map [normal]     <A-2> set "first-page-column 1:2"
      map [fullscreen] <A-2> set "first-page-column 1:2"

      # Why are these only defined for normal mode by default?
      map [fullscreen] a adjust_window best-fit
      map [fullscreen] s adjust_window width
      map [fullscreen] f follow
      map [fullscreen] d toggle_page_mode 2
      map [fullscreen] <Tab> toggle_index
      map [fullscreen] j scroll down
      map [fullscreen] k scroll up
      map [fullscreen] <C-d> scroll half-down
      map [fullscreen] <C-u> scroll half-up
      map [fullscreen] <C-o> jumplist backward
      map [fullscreen] <C-i> jumplist forward

      map [index] q quit

      # colors
      set recolor-darkcolor  "#ebdbb2"
      set recolor-lightcolor "#333333"
      set statusbar-fg "#000000"
      set statusbar-bg "#C2BFA5"
      set inputbar-fg "#FFFFFF"
      set inputbar-bg "#333333"
      set completion-highlight-fg "#F0E68C"
      set completion-highlight-bg "#6B8E23"
      # set highlight-color "#CD853F"
      # set highlight-active-color "#F0E68C"
      set notification-fg "#FFFFFF"
      set notification-bg "#333333"

      set synctex true
      set synctex-editor-command "neovim --remote +\"%{line}\" %{input}"

      set notification-error-bg       "#282828" # bg
      set notification-error-fg       "#fb4934" # bright:red
      set notification-warning-bg     "#282828" # bg
      set notification-warning-fg     "#fabd2f" # bright:yellow
      set notification-bg             "#282828" # bg
      set notification-fg             "#b8bb26" # bright:green

      set completion-bg               "#3C3836" # bg2
      set completion-fg               "#ebdbb2" # fg
      set completion-group-bg         "#3c3836" # bg1
      set completion-group-fg         "#928374" # gray
      set completion-highlight-bg     "#83a598" # bright:blue
      set completion-highlight-fg     "#3C3836" # bg2

      # Define the color in index mode
      set index-bg                    "#3C3836" # bg2
      set index-fg                    "#ebdbb2" # fg
      set index-active-bg             "#83a598" # bright:blue
      set index-active-fg             "#3C3836" # bg2

      set inputbar-bg                 "#282828" # bg
      set inputbar-fg                 "#ebdbb2" # fg

      set statusbar-bg                "#3C3836" # bg2
      set statusbar-fg                "#ebdbb2" # fg

      set highlight-color             "#fabd2f" # bright:yellow
      set highlight-active-color      "#fe8019" # bright:orange

      set default-bg                  "#282828" # bg
      set default-fg                  "#ebdbb2" # fg
      set render-loading              true
      set render-loading-bg           "#282828" # bg
      set render-loading-fg           "#ebdbb2" # fg

      # Recolor book content's color
      set recolor-lightcolor          "#282828" # bg
      set recolor-darkcolor           "#ebdbb2" # fg
      set recolor-keephue             true      # keep original color
    '';
  };
}
