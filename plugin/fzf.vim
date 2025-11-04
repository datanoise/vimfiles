" fzf plugin & settings {{{2
if !has_key(g:plugs, 'fzf.vim')
  finish
endif

let g:fzf_preview_window = ''
call CommandAlias('fzf', 'FZF')

let g:fzf_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-x': 'split',
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit'
      \ }
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

function! s:fzf_statusline()
  hi! fzf1 ctermfg=darkyellow ctermbg=242 guifg=gold3 guibg=#202020 gui=none
  hi! fzf2 ctermfg=23 ctermbg=242 guifg=#CCCCCC guibg=#202020 gui=none
  hi! fzf3 ctermfg=237 ctermbg=242 guifg=#CCCCCC guibg=#202020 gui=none
  setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction
augroup Fzf
  au! User FzfStatusLine call <SID>fzf_statusline()
augroup END
