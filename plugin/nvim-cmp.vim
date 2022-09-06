" nvim-cmp settings
if !has_key(g:plugs, 'nvim-cmp')
  finish
endif

set completeopt=menu,menuone,noselect
lua require('plugins/nvim-cmp')

