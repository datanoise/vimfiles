if exists('g:loaded_ctrlp_tabbed') && g:loaded_ctrlp_tabbed
  finish
endif
let g:loaded_ctrlp_tabbed = 1

let s:tabbed_var = {
\  'init':   'ctrlp#tabbed#init()',
\  'exit':   'ctrlp#tabbed#exit()',
\  'accept': 'ctrlp#tabbed#accept',
\  'lname':  'tabbed',
\  'sname':  'tabbed',
\  'type':   'tabbed',
\  'sort':   0,
\}

if exists('g:ctrlp_ext_vars') && !empty(g:ctrlp_ext_vars)
  let g:ctrlp_ext_vars = add(g:ctrlp_ext_vars, s:tabbed_var)
else
  let g:ctrlp_ext_vars = [s:tabbed_var]
endif

function! ctrlp#tabbed#init()
  let s = ''
  redir => s
  silent tabs
  redir END
  let list = split(substitute(s, 'Tab page \(\d\+\)\n', '\1', 'g'), '\n')
  cal remove(list, tabpagenr())
  return list
endfunc

function! ctrlp#tabbed#accept(mode, str)
  call ctrlp#exit()
  exe "tabnext ".matchstr(a:str, '^\d\+\ze.*')
endfunction

function! ctrlp#tabbed#exit()
endfunction

let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)
function! ctrlp#tabbed#id()
  return s:id
endfunction

" vim:fen:fdl=0:ts=2:sw=2:sts=2
