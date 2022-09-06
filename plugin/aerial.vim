" aerial.nvim settings
if !has_key(g:plugs, 'aerial.nvim')
  finish
endif

nnoremap <silent> \t :AerialToggle<CR>
