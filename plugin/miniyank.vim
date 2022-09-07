" nvim-miniyank settings
if !has_key(g:plugs, 'nvim-miniyank')
  finish
endif

nmap p <Plug>(miniyank-autoput)
nmap P <Plug>(miniyank-autoPut)
imap <leader>y <Plug>(miniyank-cycle)
nmap <M-y> <Plug>(miniyank-cycle)

