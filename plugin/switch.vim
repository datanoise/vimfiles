" switch.vim settings
if has('nvim')
  finish
endif

if !has_key(g:plugs, 'switch.vim')
  finish
endif

nnoremap <silent> gs :Switch<CR>
