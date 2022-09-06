" nvim-colorizer.lua settings
if !has_key(g:plugs, 'nvim-colorizer.lua')
  finish
endif

lua require('plugins/nvim-colorizer')
