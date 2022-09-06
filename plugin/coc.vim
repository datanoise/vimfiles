" coc.nvim {{{2
if !has_key(g:plugs, 'coc.nvim')
  finish
endif

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
let g:coc_snippet_next = '<c-j>'
if has_key(g:plugs, 'vim-endwise')
  imap <expr> <CR> (coc#pum#visible() ? coc#pum#confirm() : <SID>complete_brackets()."\<Plug>DiscretionaryEnd")
else
  imap <expr> <CR> (coc#pum#visible() ? coc#pum#confirm() : <SID>complete_brackets())
endif

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

nmap <silent> <leader>gi <Plug>(coc-implementation)
nmap <silent> <leader>gr <Plug>(coc-references)
nmap <silent> <leader>gy <Plug>(coc-type-definition)
nmap <silent> <leader>gd <Plug>(coc-definition)

nmap <silent> <leader>rn <Plug>(coc-rename)
inoremap <silent><expr> <c-space> coc#refresh()
