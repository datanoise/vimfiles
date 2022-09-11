" vimwiki settings
if !has_key(g:plugs, 'vimwiki')
  finish
endif

let g:vimwiki_path = '~/.vimwiki/'
let g:vimwiki_key_mappings =
      \ {
      \ 'table_mappings': 0,
      \ }
let g:vimwiki_global_ext = 0

nnoremap <silent> <leader>ww :VimwikiIndex<CR>
