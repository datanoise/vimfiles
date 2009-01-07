function! Browser ()
  let line0 = getline (".")
  let line = matchstr (line0, "http:[^[:space:]()]*")
  if line==""
    let line = matchstr (line0, "ftp:[^[:space:]()]*")
  endif
  if line==""
    let line = matchstr (line0, "file:[^[:space:]()]*")
  endif
  let line = escape (line, "#?&;|%")
  exec ':silent !open ' . "\"" . line . "\""
  redraw!
endfunction
map <leader>u :call Browser ()<CR>
