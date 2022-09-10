if !has_key(g:plugs, 'fidget.nvim')
  finish
endif

lua require"fidget".setup{}
