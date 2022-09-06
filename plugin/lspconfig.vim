if !has_key(g:plugs, 'nvim-lspconfig')
  finish
endif

lua require('plugins/lspconfig')
