function! s:qfix_opened()
  let windows = getwininfo()
  for w in windows
    if w['quickfix']
      return 1
    endif
  endfor
  return 0
endfunction

function! s:loclist_opened()
  let ll_options = getloclist(bufwinid(''), {'winid': 1})
  return has_key(ll_options, 'winid')
endfunction

function! s:qfix_toggle()
  if s:qfix_opened()
    cclose
  else
    copen
  endif
endfunction

function! s:loclist_toggle()
  if s:loclist_opened()
    lclose
  else
    if empty(getloclist('.'))
      echomsg "No location list"
    else
      lopen
    endif
  endif
endfunction

" toggles the quickfix window
command! -nargs=? QFix call <SID>qfix_toggle()
" toggles the location list window
command! -nargs=? LocList call <SID>loclist_toggle()

nnoremap <silent> \] :QFix<CR>
nnoremap <silent> \[ :LocList<CR>
