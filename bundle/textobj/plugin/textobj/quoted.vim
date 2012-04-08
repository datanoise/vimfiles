"if exists('g:loaded_textobj_quoted')  "{{{1
"  finish
"endif

"q{lslslsllsllslslsl         lsl}
"  t("alalallalalalalal")
" Interface  "{{{1
call textobj#user#plugin('quoted', {
\      '-': {
\        '*sfile*': expand('<sfile>:p'),
\        'select-a': 'aq',  '*select-a-function*': 's:select_a',
\        'select-i': 'iq',  '*select-i-function*': 's:select_i'
\      }
\    })

" Misc.  "{{{1
let s:pair_chars = "['\"})]"

function! s:select_a()
  let s:flags = 'b'

  let line=line(".")

  call search(s:pair_chars,'',line)

  let char = getline('.')[col('.')-1]

  let end_pos = getpos('.')

  let pair_char = s:pair_char(char)

  call search(pair_char, s:flags, line)

  let start_pos = getpos('.')

  return ['v', start_pos, end_pos]
endfunction

function! s:select_i()
  let s:flags = 'b'

  let line=line(".")

  call search(s:pair_chars,'', line)

  let char = getline('.')[col('.')-1]

  normal h

  let end_pos = getpos('.')

  let pair_char = s:pair_char(char)

  call search(pair_char, s:flags, line)

  normal l

  let start_pos = getpos('.')

  return ['v', start_pos, end_pos]
endfunction

function! s:pair_char(char)
    if a:char == "}"
        return "{"
    elseif a:char == "\""
        return "\""
    elseif a:char == "'"
        return "'"
    elseif a:char == ")"
        return "("
    endif
endfunction

" Fin.  "{{{1

let g:loaded_textobj_quoted = 1

" __END__
" vim: foldmethod=marker
