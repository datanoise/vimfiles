" vim-endwise settings
if !has_key(g:plugs, 'vim-endwise')
  finish
endif

" endwise bindings
let g:endwise_no_mappings = 1
imap <C-X><CR>   <CR><Plug>AlwaysEnd
if !has_key(g:plugs, 'coc.nvim')
  imap <expr> <CR> (pumvisible() ? "\<C-Y>\<CR>" : <SID>complete_brackets()."\<Plug>DiscretionaryEnd")
endif

