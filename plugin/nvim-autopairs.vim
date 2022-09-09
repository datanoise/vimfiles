if !has_key(g:plugs, 'nvim-autopairs')
  finish
endif

lua require("nvim-autopairs").setup {ignored_next_char = [=[[%w%%%'%[%"]]=]}
