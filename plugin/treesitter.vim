" treesitter settings
if !has_key(g:plugs, 'nvim-treesitter')
  finish
endif

" syntax off

lua require('plugins/treesitter')

" set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
