-- Define macros
local o = vim.o
local bo = vim.bo
local wo = vim.wo
o.modelines=0
vim.api.nvim_exec([[set clipboard=unnamedplus]], false)
o.tabstop=2
o.softtabstop=2
o.shiftwidth=2
o.expandtab=true
o.maxmempattern=2500
o.mouse='n'
-- gui stuff
vim.g.gruvbox_material_background='hard'
vim.cmd('colorscheme gruvbox-material')
o.guifont='FiraCode Nerd Font:h16'
vim.g.neovide_cursor_animation_length=0.1
vim.g.neovide_cursor_animate_in_insert_mode=0
wo.number=true
wo.relativenumber=true
wo.cursorline=true
wo.breakindent=true
wo.linebreak=true
o.scrolloff=8
o.termguicolors=true
o.hlsearch=false
o.incsearch=true
