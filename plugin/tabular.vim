" tabular settings
if !has_key(g:plugs, 'tabular')
  finish
endif

nnoremap <silent> g= :Tabularize assignment<CR>
xnoremap <silent> g= :Tabularize assignment<CR>
