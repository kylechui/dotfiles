" Open/refresh settings
nnoremap <silent><leader>s :execute("FZF ".expand('$VIMCONFIG'))<CR>
nnoremap <leader>r :source $MYVIMRC<CR>
" Open snippets
nnoremap <silent><leader>u :UltiSnipsEdit<CR>
" Open TODO List
nnoremap <silent><leader>t :e /mnt/c/Users/kylec/github/TODO.txt<CR>
" Ctrl-P to fuzzy find files
nnoremap <silent><c-p> :FZF<CR>
" Open the file explorer (FERN)
nnoremap <silent><c-\> :Fern . -drawer -reveal=% -toggle -width=36<CR><C-w>=
" Remap Ctrl-S to save files
nnoremap <silent><c-s> :up!<CR>
inoremap <silent><c-s> <Esc>:up!<CR>
vnoremap <silent><c-s> <Esc>:up!<CR>
" Buffer deletion
nnoremap <silent><c-w> :bd!<CR>
inoremap <silent><c-w> <Esc>:bd!<CR>
" Tab creation/navigation
nnoremap <silent><c-t> :tabnew<CR>
nnoremap <silent><c-tab> :tabn<CR>
nnoremap <silent><c-s-tab> :tabp<CR>
inoremap <silent><c-tab> <Esc>:tabn<CR>
inoremap <silent><c-s-tab> <Esc>:tabp<CR>
inoremap <silent><c-t> <Esc>:tabnew<CR>
" Navigate wrapped lines by default
nnoremap <expr> j v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj'
nnoremap <expr> k v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk'
vnoremap <expr> j v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj'
vnoremap <expr> k v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk'
" Moving lines up and down
nnoremap <silent>J :m+<CR>==
nnoremap <silent>K :m-2<CR>==
vnoremap <silent>J :m '>+1<CR>gv
vnoremap <silent>K :m '<-2<CR>gv
" Make Ctrl-Backspace delete words
cnoremap <c-BS> <c-w>
inoremap <c-BS> <c-w>
tnoremap <c-BS> <c-w>
" Make Y yank to the end of line
nnoremap Y y$
" Paste in insert mode
inoremap <silent><c-v> <c-r>"
" Indent and dedent blocks of text
vnoremap <silent>> >gv
" Super scuffed workaround while Neovide is getting worked on
vnoremap <silent><s-lt> <gv
" Make . work for visually selected text
vnoremap . :normal.<CR>
" Paste while keeping contents of current register
vnoremap <leader>p "_dP
" Resizing windows
nnoremap <m-j> :resize -2<CR>
nnoremap <m-k> :resize +2<CR>
nnoremap <m-h> :vertical resize +2<CR>
nnoremap <m-l> :vertical resize -2<CR>
" Better window navigation
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l
" Enter to fold/unfold code blocks
nnoremap <silent><CR> @=(foldlevel('.')?'za':"\<lt>CR>")<CR>
" Double click to visit file
nnoremap <silent><2-LeftMouse> gf
" Ctrl-/ to comment out lines/blocks of code
nnoremap <silent><c-/> :Commentary<CR>
vnoremap <silent><c-/> :Commentary<CR>gv
" Coc keybinds
" inoremap <silent><expr> <c-j>
"       \ pumvisible() ? "\<C-n>" :
"       \ coc#refresh()
" inoremap <expr><c-k> pumvisible() ? "\<C-p>" : coc#refresh
" inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
"                               \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" Vim be good
nnoremap <leader>bg :VimBeGood<CR>
" Spell check
inoremap <c-l> <c-g>u<esc>[s1z=`]a<c-g>u
augroup sortTODO
  autocmd!
  " Sort uncompleted tasks
  autocmd BufRead TODO.txt nnoremap <buffer><silent><leader>r mo/=DONE=<CR>ml:1,'l-1sort<CR>'o
  " Mark as done
  autocmd BufRead TODO.txt nnoremap <buffer><silent><leader>d jmok/=DONE=<CR>ml''I\|-<Esc>:m'l<CR>'o
  " Mark as important
  autocmd BufRead TODO.txt nnoremap <buffer><silent><leader>i mlI!!<Esc>ggV/=DONE=<CR>k:sort<CR>'l
  " Unmark
  autocmd BufRead TODO.txt nnoremap <buffer><silent><leader>u 0xx/=DONE=<CR>ml'':move'l-1<CR>ggV'lk:sort<CR>
augroup END
