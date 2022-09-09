if !has_key(g:plugs, 'nvim-autopairs')
  finish
endif

lua require('plugins/autopairs')
