if exists("g:go_loaded_godef")
  finish
endif
let g:go_loaded_godef = 1


function! s:current_offset()
    let pos = getpos(".")[1:2]
    if &encoding == 'utf-8'
        let offs = line2byte(pos[0]) + pos[1] - 1
    else
        let c = pos[1]
        let buf = line('.') == 1 ? "" : (join(getline(1, pos[0] - 1), "\n") . "\n")
        let buf .= c == 1 ? "" : getline(pos[0])[:c-2]
        let offs = len(iconv(buf, &encoding, "utf-8"))
    endif
    return offs
endfunction

function s:execute_godef(args)
    let cmd = g:go_godef_bin . " -f=" . shellescape(expand("%")) . " -i " . join(map(copy(a:args), 'shellescape(v:val)'))
    let out=system(cmd, join(getbufline(bufnr('%'), 1, '$'), "\n"))
    return out
endfunction

function! GodefSignature()
    let out = s:execute_godef(["-o=" . s:current_offset(), "-t=true"])
    let out = substitute(substitute(out, '.\{-}\n', '', ''), '\n', ' ', 'g')
    echomsg out
endfunction

" modified and improved version of vim-godef
function! Godef(...)
    if !len(a:000)
        let arg = "-o=" . s:current_offset()
    else
        let arg = a:1
    endif

    let out=s:execute_godef([arg])

    let old_errorformat = &errorformat
    let &errorformat = "%f:%l:%c"

    if out =~ 'godef: '
        let out=substitute(out, '\n$', '', '')
        echom out
    else
        lexpr out
    end
    let &errorformat = old_errorformat
endfunction

if !hasmapto('<Plug>(go-def)')
  nnoremap <silent> <Plug>(go-def) :<C-u>call Godef()<CR>
endif

if !hasmapto('<Plug>(go-def-vertical)')
  nnoremap <silent> <Plug>(go-def-vertical) :vsp <CR>:<C-u>call Godef()<CR>
endif

if !hasmapto('<Plug>(go-def-split)')
  nnoremap <silent> <Plug>(go-def-split) :sp <CR>:<C-u>call Godef()<CR>
endif

if !hasmapto('<Plug>(go-def-tab)')
  nnoremap <silent> <Plug>(go-def-tab) :tab split <CR>:<C-u>call Godef()<CR>
endif


command! -range -nargs=* GoDef :call Godef(<f-args>)
autocmd FileType go nnoremap <buffer> gd :<C-u>call Godef()<CR>
autocmd FileType go nnoremap <buffer> gD :call GodefSignature()<CR>
