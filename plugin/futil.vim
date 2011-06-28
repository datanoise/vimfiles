"
" :Rename[!] {newname}
"
command! -nargs=* -complete=file -bang Rename :call Rename("<args>", "<bang>")

function! Rename(name, bang)
  let l:curfile = expand("%:p")
  let v:errmsg = ""
  silent! exe "saveas" . a:bang . " " . a:name
  if v:errmsg =~# '^$\|^E329'
    if expand("%:p") !=# l:curfile && filewritable(expand("%:p"))
      silent exe "bwipe! " . l:curfile
      if delete(l:curfile)
        echoerr "Could not delete " . l:curfile
      endif
    endif
  else
    echoerr v:errmsg
  endif
endfunction

"
" :Rm[!]
"
command! -nargs=0 Rm :call Rmove()

fun! Rmove()
  if confirm('Are you sure?', "&Yes\n&No") == 1
    sil !rm %
    bwipe!
  endif
  echo
endf
