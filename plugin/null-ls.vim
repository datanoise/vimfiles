if !has_key(g:plugs, 'null-ls.nvim')
  finish
endif

lua require('plugins/null-ls')
