if exists("g:loaded_url")
  finish
endif
let g:loaded_url = 1

function! Browser ()
  let line = getline (".")
  let basic_pattern = ":[^[:space:]()<>\"']*"
  let protocols = ["http", "https", "ftp", "file"]
  for protocol in protocols
    let pattern = protocol . basic_pattern
    let url = matchstr(line, pattern)
    if url != ""
      let url = escape(url, "#?&;|%")
      exec ':silent !open ' . "\"" . url . "\""
      break
    endif
  endfor
  redraw!
endfunction

noremap <silent> <leader>u :call Browser ()<CR>
