-- Define macros
local o = vim.o
local bo = vim.bo
local wo = vim.wo
o.modelines=0
--o.clipboard=unnamedplus
o.tabstop=2
o.softtabstop=2
o.shiftwidth=2
o.expandtab=true
o.maxmempattern=2500

-- gui stuff
--o.background=dark
vim.g.gruvbox_material_background = 'hard'
vim.cmd('colorscheme gruvbox-material')
wo.number=true
wo.relativenumber=true
wo.cursorline=true
wo.breakindent=true
wo.linebreak=true
o.scrolloff=8
o.termguicolors=true
o.hlsearch=false
o.incsearch=true
