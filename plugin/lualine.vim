if !has_key(g:plugs, 'lualine.nvim')
  finish
endif

lua require('plugins/lualine')
