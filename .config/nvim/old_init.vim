" Set leader
let mapleader="\<space>"
" Import other files
let $VIMCONFIG=trim(expand('$MYVIMRC'), 'init.vim')
source $VIMCONFIG/Source Files/plugins.vim
source $VIMCONFIG/Source Files/pluginSettings.vim
source $VIMCONFIG/Source Files/keybinds.vim
source $VIMCONFIG/Source Files/textShortcuts.vim
" Go into work directory
cd ~/Documents/github
" Security thing
set modelines=0
set clipboard=unnamedplus
set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set breakindent
set linebreak
set scrolloff=8
set maxmempattern=2500
" GUI Stuff
set guifont=FiraPatchedW\ Code:h14
let g:gruvbox_contrast_dark='hard'
colorscheme gruvbox
set background=dark
set number relativenumber
set nohlsearch incsearch
set cursorline
set termguicolors
let g:neovide_cursor_animation_length=0.1
let g:neovide_cursor_animate_in_insert_mode=0
" FZF Settings
let $FZF_DEFAULT_OPTS='--info=inline'
" Yank highlighting
let g:highlightedyank_highlight_duration=300
highlight HighlightedyankRegion guibg=#625B58
" Markdown formatting
augroup writingMode
  autocmd!
  autocmd FileType md,text set textwidth=80
augroup END
" Make the window translucent if focus is lost
augroup toggleTranslucency
  autocmd!
  autocmd FocusLost * let g:neovide_transparency=0.8
  autocmd FocusGained * let g:neovide_transparency=1
augroup END
" Spell Checker
augroup spellCheck
  autocmd!
  autocmd FileType text,md,tex setlocal spell
  autocmd FileType text,md,tex set spelllang=en_gb
augroup END
function! PDFopener()
  let cmd='zathura --fork "'.expand('%:p').'"'
  let texPath=expand('%:p')[0:-4].'tex'
  execute('bdelete')
  if filereadable(texPath)
    execute('edit '.texPath)
    set ft=tex
  endif
  call system(cmd)
endfunction
augroup openPDF
  autocmd!
  autocmd FileType pdf call PDFopener()
augroup END
