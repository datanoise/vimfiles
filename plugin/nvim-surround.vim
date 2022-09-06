" nvim-surround.nvim settings
if !has_key(g:plugs, 'nvim-surround')
  finish
endif

lua require("nvim-surround").setup()

