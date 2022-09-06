" vim-surround settings
if !has_key(g:plugs, 'vim-surround')
  finish
endif

xmap s   <Plug>VSurround
xmap gs  <Plug>VgSurround

