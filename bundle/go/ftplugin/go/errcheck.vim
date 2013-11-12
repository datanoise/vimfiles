if exists("g:did_ftplugin_go_errcheck") || !executable("errcheck")
  finish
endif

function! s:ErrCheck(...) abort
    let package = a:0
    if package == ''
        let package = shellescape(expand('%:p:h'))
    endif
    let errors = system('errcheck ' . package)
    let old_errfmt = &errorformat
    let &errorformat = "%f:%l:%c\t%m"
    cexpr errors
    let &errorformat = old_errfmt
endfunction

command! -buffer -nargs=? -complete=customlist,go#complete#Package ErrCheck call s:ErrCheck(<f-args>)

let g:did_ftplugin_go_errcheck = 1

" vim:ts=4:sw=4:et
