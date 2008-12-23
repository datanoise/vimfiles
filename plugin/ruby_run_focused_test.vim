if exists("loaded_run_focused_test")
  finish
endif
let g:loaded_run_focused_test = 1

function! s:FindFocusedTestName()
  let cur_line = line(".")
  while cur_line != 0
    let line = getline(cur_line)
    let method = matchstr(line, '\<def\s\+\zstest_.\+\>')
    if method != ""
      return method
    else
      let cur_line -= 1
    endif
  endwhile
  return ""
endfunction

function! <SID>RunFocusedTest()
  let focused_test = s:FindFocusedTestName()
  if focused_test == ""
    echomsg "No tests found"
    return
  endif

  echomsg "Running test " . focused_test
  let cmd = "ruby " . expand("%") . " -n " . focused_test
  echo system(cmd)
endfunction

function! <SID>RunAllTests()
  echomsg "Running all tests"
  echo system("ruby ". expand("%"))
endfunction

au FileType ruby nnoremap <buffer> <Leader>T :call <SID>RunFocusedTest()<CR>
au FileType ruby nnoremap <buffer> <Leader>R :call <SID>RunAllTests()<CR>
