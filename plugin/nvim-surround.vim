" nvim-surround.nvim settings
if has('nvim')
  finish
endif

if !has_key(g:plugs, 'nvim-surround')
  finish
endif

lua require("nvim-surround").setup()
