if !has_key(g:plugs, 'spellsitter.nvim')
  finish
endif

lua require('spellsitter').setup()
