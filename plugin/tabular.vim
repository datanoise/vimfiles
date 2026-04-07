" tabular settings
if has('nvim')
  finish
endif

if !has_key(g:plugs, 'tabular')
  finish
endif

nnoremap <silent> g= :Tabularize assignment<CR>
xnoremap <silent> g= :Tabularize assignment<CR>
