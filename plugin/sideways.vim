" sideways.vim settings
if !has_key(g:plugs, 'sideways.vim')
  finish
endif

nnoremap <silent> <leader>< :<C-u>SidewaysLeft<CR>
nnoremap <silent> <leader>> :<C-u>SidewaysRight<CR>
nmap <silent> <leader>si <Plug>SidewaysArgumentInsertBefore
nmap <silent> <leader>sa <Plug>SidewaysArgumentAppendAfter
nmap <silent> <leader>sI <Plug>SidewaysArgumentInsertFirst
nmap <silent> <leader>sA <Plug>SidewaysArgumentAppendLast
omap aa <Plug>SidewaysArgumentTextobjA
xmap aa <Plug>SidewaysArgumentTextobjA
omap ia <Plug>SidewaysArgumentTextobjI
xmap ia <Plug>SidewaysArgumentTextobjI

