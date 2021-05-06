lua require'bufferline'.setup{}
let g:nvim_tree_width = 36
lua <<EOF
    local tree_cb = require'nvim-tree.config'.nvim_tree_callback
    vim.g.nvim_tree_bindings = {
      ["."]              = tree_cb("toggle_dotfiles"),
      ["n"]              = tree_cb("create"),
      ["r"]              = tree_cb("full_rename"),
      ["<"]              = tree_cb("dir_up"),
    }
EOF

lua << EOF
local gl = require("galaxyline")
local gls = gl.section

gl.short_line_list = {" "} -- keeping this table { } as empty will show inactive statuslines

local colors = {
    bg = "#3C3836",
    line_bg = "#3C3836",
    fg = "#EBDBB2",
    fg_green = "#65A380",
    yellow = "#A3BE8C",
    cyan = "#22262C",
    darkblue = "#61AFEF",
    green = "#B8BB26",
    orange = "#FE8019",
    purple = "#D3869B",
    magenta = "#C678DD",
    blue = "#83A598",
    red = "#FB4934",
    lightbg = "#504945",
    nord = "#D5C4A1",
    greenYel = "#EBCB8B"
}

gls.left[1] = {
    leftRounded = {
        provider = function()
            return ""
        end,
        highlight = {colors.nord, colors.bg}
    }
}

gls.left[2] = {
    statusIcon = {
        provider = function()
            return "   "
        end,
        highlight = {colors.bg, colors.nord},
        separator = " ",
        separator_highlight = {colors.lightbg, colors.lightbg}
    }
}

gls.left[3] = {
    FileIcon = {
        provider = "FileIcon",
        condition = buffer_not_empty,
        highlight = {require("galaxyline.provider_fileinfo").get_file_icon_color, colors.lightbg}
    }
}

gls.left[4] = {
    FileName = {
        provider = {"FileName", "FileSize"},
        condition = buffer_not_empty,
        highlight = {colors.fg, colors.lightbg}
    }
}

gls.left[5] = {
    teech = {
        provider = function()
            return ""
        end,
        separator = " ",
        highlight = {colors.lightbg, colors.bg}
    }
}

local checkwidth = function()
    local squeeze_width = vim.fn.winwidth(0) / 2
    if squeeze_width > 40 then
        return true
    end
    return false
end

gls.left[6] = {
    DiffAdd = {
        provider = "DiffAdd",
        condition = checkwidth,
        icon = "   ",
        highlight = {colors.greenYel, colors.line_bg}
    }
}

gls.left[7] = {
    DiffModified = {
        provider = "DiffModified",
        condition = checkwidth,
        icon = " ",
        highlight = {colors.orange, colors.line_bg}
    }
}

gls.left[8] = {
    DiffRemove = {
        provider = "DiffRemove",
        condition = checkwidth,
        icon = " ",
        highlight = {colors.red, colors.line_bg}
    }
}

gls.left[9] = {
    LeftEnd = {
        provider = function()
            return " "
        end,
        separator = " ",
        separator_highlight = {colors.line_bg, colors.line_bg},
        highlight = {colors.line_bg, colors.line_bg}
    }
}

gls.left[10] = {
    DiagnosticError = {
        provider = "DiagnosticError",
        icon = "  ",
        highlight = {colors.red, colors.bg}
    }
}

gls.left[11] = {
    Space = {
        provider = function()
            return " "
        end,
        highlight = {colors.line_bg, colors.line_bg}
    }
}

gls.left[12] = {
    DiagnosticWarn = {
        provider = "DiagnosticWarn",
        icon = "  ",
        highlight = {colors.blue, colors.bg}
    }
}

gls.right[1] = {
    GitIcon = {
        provider = function()
            return "   "
        end,
        condition = require("galaxyline.provider_vcs").check_git_workspace,
        highlight = {colors.green, colors.line_bg}
    }
}

gls.right[2] = {
    GitBranch = {
        provider = "GitBranch",
        condition = require("galaxyline.provider_vcs").check_git_workspace,
        highlight = {colors.green, colors.line_bg}
    }
}

gls.right[3] = {
    right_LeftRounded = {
        provider = function()
            return ""
        end,
        separator = " ",
        separator_highlight = {colors.bg, colors.bg},
        highlight = {colors.red, colors.bg}
    }
}

gls.right[4] = {
    ViMode = {
        provider = function()
            local alias = {
                n = "NORMAL",
                i = "INSERT",
                c = "COMMAND",
                V = "VISUAL",
                [""] = "VISUAL",
                v = "VISUAL",
                R = "REPLACE"
            }
            return alias[vim.fn.mode()]
        end,
        highlight = {colors.bg, colors.red}
    }
}

gls.right[5] = {
    PerCent = {
        provider = "LinePercent",
        separator = " ",
        separator_highlight = {colors.red, colors.red},
        highlight = {colors.bg, colors.fg}
    }
}

gls.right[6] = {
    rightRounded = {
        provider = function()
            return ""
        end,
        highlight = {colors.fg, colors.bg}
    }
}
EOF

" VimTeX Settings
let g:tex_comment_nospell=1
let g:tex_flavor='latex'
let g:vimtex_view_general_viewer='zathura'
" let g:vimtex_view_method='mupdf'
let g:vimtex_compiler_latexmk={
        \ 'options' : [
        \   '-aux-directory=/tmp/latexout',
        \   '-synctex=1',
        \   '-verbose',
        \   '-file-line-error',
        \ ],
        \}
" Markdown Settings
let g:mkdp_refresh_slow=1
let g:mkdp_markdown_css='~/github/poweruserdo.github.io/styles.css'
nnoremap <leader>ll :MarkdownPreview<CR>
" DelimitMate Settings
let g:delimitMate_expand_cr=1
augroup smartPairsLaTeX
  autocmd!
  autocmd FileType tex let b:delimitMate_smart_matchpairs='^\%(\w\|\!\)'
  autocmd FileType tex let b:delimitMate_quotes=''
augroup END
" UltiSnips Settings
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<tab>'
let g:UltiSnipsJumpBackwardTrigger='<s-tab>'
let g:UltiSnipsSnippetDirectories=[$VIMCONFIG.'mySnippets']
let g:UltiSnipsEditSplit='vertical'
