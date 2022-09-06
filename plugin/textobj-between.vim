" textobj-between settings
if !has_key(g:plugs, 'vim-textobj-between')
  finish
endif

let g:textobj_between_no_default_key_mappings = 1
xmap ac  <Plug>(textobj-between-a)
omap ac  <Plug>(textobj-between-a)
xmap ic  <Plug>(textobj-between-i)
omap ic  <Plug>(textobj-between-i)
