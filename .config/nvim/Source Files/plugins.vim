call plug#begin('~/.vim/plugged')
" Fuzzy file finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Gruvbox color theme
Plug 'gruvbox-community/gruvbox'
" Status line and bufferline
Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}
Plug 'akinsho/nvim-bufferline.lua'
" Discord integration
Plug 'andweeb/presence.nvim'
" File tree explorer
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
" LaTeX
Plug 'lervag/vimtex'
" Markdown
Plug 'tpope/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
" Surround stuff with other stuff
Plug 'tpope/vim-surround'
" Universal way to add comments to a file
Plug 'tpope/vim-commentary'
" Flash highlight yanked text
Plug 'machakann/vim-highlightedyank'
" Autocomplete matching braces and quotes
Plug 'Raimondi/delimitMate'
" Fast movements
Plug 'justinmk/vim-sneak'
" Conquer of Completion
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Snippets
Plug 'sirver/ultisnips'
" Get good (needs Neovim 0.5)
Plug 'ThePrimeagen/vim-be-good'
" Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
call plug#end()
