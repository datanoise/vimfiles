" vim-endwise settings
if !has_key(g:plugs, 'vim-endwise')
  finish
endif

function! s:complete_brackets()
  let l:line = getline('.')
  let l:c = l:line[col('.')-2]
  let l:x = l:line[col('.')-1]
  if l:c =~# '[{\[\(]' && match(l:line, '[}\]\)]', col('.')) == -1
    if l:c ==# '['
      let l:b = ']'
    elseif l:c ==# '('
      let l:b = ')'
    elseif l:c ==# '{'
      let l:b = '}'
    else
      return "\<CR>"
    endif
    if l:x ==# l:b
      let l:b = ''
    endif
    return "\<CR>".l:b."\<C-O>O"
  else
    return "\<CR>"
  endif
endfunction

" endwise bindings
let g:endwise_no_mappings = 1
imap <C-X><CR>   <CR><Plug>AlwaysEnd
if !has_key(g:plugs, 'coc.nvim')
  imap <expr> <CR> (pumvisible() ? "\<C-Y>\<CR>" : <SID>complete_brackets()."\<Plug>DiscretionaryEnd")
endif

