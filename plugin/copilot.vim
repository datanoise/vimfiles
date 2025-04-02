if !has_key(g:plugs, 'copilot.vim')
  finish
endif

" let g:copilot_no_tab_map = v:true
imap <silent><script><expr> <M-k> copilot#Accept("\<CR>")
imap <silent> <M-l> <Plug>(copilot-accept-word)
imap <silent> <C-l> <Plug>(copilot-accept-word)
