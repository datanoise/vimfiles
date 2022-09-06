" switch.vim settings
if !has_key(g:plugs, 'switch.vim')
  finish
endif

nnoremap <silent> gs :Switch<CR>

