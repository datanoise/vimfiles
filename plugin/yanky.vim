if !has_key(g:plugs, 'yanky.nvim')
  finish
endif

lua require('plugins/yanky')
