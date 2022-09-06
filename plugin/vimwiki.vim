" vimwiki settings
if !has_key(g:plugs, 'vimwiki')
  finish
endif

let g:vimwiki_path = '~/.vimwiki/'
let g:vimwiki_key_mappings =
      \ {
      \ 'table_mappings': 0,
      \ }
