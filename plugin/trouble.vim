if !has_key(g:plugs, 'trouble.nvim')
  finish
endif

nnoremap <leader>gt :TroubleToggle<CR>
