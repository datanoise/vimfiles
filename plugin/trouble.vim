if !has_key(g:plugs, 'trouble.nvim')
  finish
endif

nnoremap <silent> <leader>gt :TroubleToggle<CR>
