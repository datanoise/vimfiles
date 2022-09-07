" aerial.nvim settings
if !has_key(g:plugs, 'aerial.nvim')
  finish
endif

lua require('aerial').setup {}
nnoremap <silent> \t :AerialToggle<CR>

