return {
    -- Fix font size issue with i3wm
    adjust_window_size_when_changing_font_size = false,
    -- Set cursor style to vertical bar
    default_cursor_style = "SteadyBar",
    -- Minimalist window settings
    hide_tab_bar_if_only_one_tab = true,
    window_decorations = "RESIZE",
    window_padding = {
        left = 0,
        right = 0,
        top = 0,
        bottom = 0,
    },
    -- Kanagawa colors
    -- https://github.com/rebelot/kanagawa.nvim/blob/master/extras/wezterm.lua
    force_reverse_video_cursor = true,
    colors = {
        foreground = "#dcd7ba",
        background = "#1f1f28",

        cursor_bg = "#c8c093",
        cursor_fg = "#c8c093",
        cursor_border = "#c8c093",

        selection_fg = "#c8c093",
        selection_bg = "#2d4f67",

        scrollbar_thumb = "#16161d",
        split = "#16161d",

        ansi = { "#090618", "#c34043", "#76946a", "#c0a36e", "#7e9cd8", "#957fb8", "#6a9589", "#c8c093" },
        brights = { "#727169", "#e82424", "#98bb6c", "#e6c384", "#7fb4ca", "#938aa9", "#7aa89f", "#dcd7ba" },
        indexed = { [16] = "#ffa066", [17] = "#ff5d62" },
    },
    -- Font settings
    font = wezterm.font_with_fallback({
        "Iosevka",
        "Symbols Nerd Font Mono",
    }),
    font_size = 14.0,
    default_prog = { "fish", "-l", "-i" },
}
