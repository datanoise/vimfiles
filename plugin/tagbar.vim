" Tagbar settings

if !has_key(g:plugs, 'tagbar')
  finish
endif

let g:tagbar_left      = 1
let g:tagbar_width     = 30
let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1
let g:tagbar_sort = 0
nnoremap <silent> \t  :TagbarToggle<CR>
