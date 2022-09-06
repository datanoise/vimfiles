" nvim-miniyank settings
if !has_key(g:plugs, 'nvim-miniyank')
  finish
endif

map p <Plug>(miniyank-autoput)
map P <Plug>(miniyank-autoPut)
map <leader>y <Plug>(miniyank-cycle)
map <M-y> <Plug>(miniyank-cycle)

