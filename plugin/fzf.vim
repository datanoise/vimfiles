" fzf plugin & settings {{{2
if !has_key(g:plugs, 'fzf.vim')
  finish
endif

let g:fzf_preview_window = ''
execute 'cnoremap <M-t> FZF '
execute 'nnoremap <M-t> :FZF '
call CommandAlias('fzf', 'FZF')

if !has_key(g:plugs, 'fzf-lua')
  nnoremap <silent> <Leader>m :Files<CR>
  nnoremap <silent> <Leader>F :Files %:h<CR>
  nnoremap <silent> <Leader>l :Buffers<CR>
  nnoremap <silent> <Leader>n :BTag<CR>
  nnoremap <silent> <Leader>e :History<CR>
  nnoremap <silent> <Leader>B :BCommits<CR>
  nnoremap <silent> <Leader>C :Commits<CR>
endif

function! s:fzf_statusline()
  hi! fzf1 ctermfg=darkyellow ctermbg=242 guifg=gold3 guibg=#202020 gui=none
  hi! fzf2 ctermfg=23 ctermbg=242 guifg=#CCCCCC guibg=#202020 gui=none
  hi! fzf3 ctermfg=237 ctermbg=242 guifg=#CCCCCC guibg=#202020 gui=none
  setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction
augroup Fzf
  au! User FzfStatusLine call <SID>fzf_statusline()
augroup END
