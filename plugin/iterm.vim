if exists("g:loaded_iterm")
  finish
endif
let g:loaded_iterm = 1

if has('gui_running') || $TERM_PROGRAM != 'iTerm.app'
  finish
endif

" some handful mappings
if !has('nvim')
  execute "set <M-q>=\eq"
  execute "set <M-t>=\et"
  execute "set <Home>=\ea"
  execute "set <End>=\ee"
  execute "set <S-Left>=\eb"
  execute "set <S-Right>=\ef"
endif
