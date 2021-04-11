" Discord Integration Settings
let g:vimsence_small_text = 'NeoVim'
let g:vimsence_small_image = 'neovim'
let g:vimsence_editing_details = 'Editing: {}'
let g:vimsence_editing_state = 'Working in {}'
" let g:vimsence_file_explorer_text = 'In Fern'
" let g:vimsence_file_explorer_details = 'Moving things around'
" let g:vimsence_custom_icons = {'filetype': 'iconname'}
" FERN Settings
let g:fern#disable_default_mappings=1
let g:fern#mark_symbol='●'
let g:fern#renderer#default#collapsed_symbol='▶ '
let g:fern#renderer#default#expanded_symbol='▼ '
function! FernInit()
  nmap <buffer><expr>
        \ <Plug>(fern-my-open-expand-collapse)
        \ fern#smart#leaf(
        \   "\<Plug>(fern-action-open:select)",
        \   "\<Plug>(fern-action-expand)",
        \   "\<Plug>(fern-action-collapse)",
        \ )
  nmap <buffer> <CR> <Plug>(fern-my-open-expand-collapse)
  nmap <buffer> <2-LeftMouse> <Plug>(fern-my-open-expand-collapse)
  nmap <buffer> n <Plug>(fern-action-new-path)
  nmap <buffer> d <Plug>(fern-action-remove)
  nmap <buffer> m <Plug>(fern-action-move)
  nmap <buffer> r <Plug>(fern-action-rename)
  nmap <buffer> . <Plug>(fern-action-hidden:toggle)
  nmap <buffer> <tab> <Plug>(fern-action-mark:toggle)
  nmap <buffer> <nowait> h <Plug>(fern-action-leave)
  nmap <buffer> <nowait> l <Plug>(fern-action-enter)
endfunction
augroup FernEvents
  autocmd!
  autocmd FileType fern call FernInit()
augroup END
" VimTeX Settings
let g:tex_comment_nospell=1
let g:tex_flavor='latex'
let g:vimtex_view_general_viewer='zathura'
" let g:vimtex_latexmk_progname='neovide'
let g:vimtex_compiler_latexmk={
        \ 'options' : [
        \   '-auxdir=/tmp/latexout',
        \   '-shell-escape',
        \   '-synctex=1',
        \ ],
        \}
" Markdown Settings
let g:mkdp_refresh_slow=1
let g:mkdp_markdown_css='~/github/poweruserdo.github.io/styles.css'
nnoremap <silent><s-BS> :MarkdownPreview<CR>
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
