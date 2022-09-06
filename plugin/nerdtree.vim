" NERD_tree settings {{{2
if !has_key(g:plugs, 'nerdtree')
  finish
endif

let g:NERDTreeQuitOnOpen        = 1 " Close NERDTree when a file is opened
let g:NERDTreeHijackNetrw       = 0
let g:NERDTreeIgnore            = ['\.o$', '\~$', '\.class$']
let g:NERDTreeMinimalUI         = 0
let g:NERDTreeDirArrows         = 1
let g:NERDTreeRespectWildIgnore = 1
nnoremap <silent> <leader>f  :exec 'NERDTree' . expand('%:p:h')<CR>

