" vim-commentary settings
if has_key(g:plugs, 'vim-commentary')
  finish
end

map  gc  <Plug>Commentary
nmap gcc <Plug>CommentaryLine
map  g/  <Plug>Commentary
nmap g/ <Plug>CommentaryLine

