if !has_key(g:plugs, 'gitsigns.nvim')
  finish
endif

lua require('gitsigns').setup()
