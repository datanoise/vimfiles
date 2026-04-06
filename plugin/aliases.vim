function! CommandAlias(input, output)
  execute 'cnoreabbrev <expr> ' . a:input
        \ . ' ((getcmdtype() ==# ":" && getcmdline() ==# "' . a:input . '")'
        \ . '? ("' . a:output . '") : ("' . a:input . '"))'
endfunction

function! CommandAliasForBuffer(input, output)
  execute 'cnoreabbrev <buffer> <expr> ' . a:input
        \ . ' ((getcmdtype() ==# ":" && getcmdline() ==# "' . a:input . '")'
        \ . '? ("' . a:output . '") : ("' . a:input . '"))'
endfunction
