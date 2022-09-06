" which-key.nvim settings
if !has_key(g:plugs, 'which-key.nvim')
  finish
endif

lua require("which-key").setup()

