call plug#begin('~/.vim/plugged')
" Fuzzy file finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Gruvbox color theme
Plug 'gruvbox-community/gruvbox'
" Status line
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
" Discord integration
Plug 'vimsence/vimsence'
" File tree explorer
Plug 'lambdalisue/fern.vim'
" LaTeX
Plug 'lervag/vimtex'
" Markdown
Plug 'tpope/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
" Surround text with quotes, braces, etc.
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
" Get good (needs Neovim 0.5)
" Plug 'ThePrimeagen/vim-be-good'
" Snippets
Plug 'sirver/ultisnips'
call plug#end()
