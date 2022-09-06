" treesitter settings
if !has_key(g:plugs, 'nvim-treesitter')
  finish
endif

lua require('plugins/treesitter')

