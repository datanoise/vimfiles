function! s:buf_opened(name)
  redir => buffers
  silent ls
  redir END

  for buf in split(buffers, '\n')
    if match(buf, "[" . a:name . "\\]") > -1
      return 1
    endif
  endfor
  return 0
endfunction

function! s:qfix_toggle()
  if s:buf_opened("Quickfix List")
    cclose
  else
    copen
  endif
endfunction

function! s:loclist_toggle()
  if s:buf_opened("Location List")
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
