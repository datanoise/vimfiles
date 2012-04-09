if exists('g:loaded_textobj_quoted')  "{{{1
  finish
endif

" Interface  "{{{1
call textobj#user#plugin('quoted', {
\      '-': {
\        '*sfile*': expand('<sfile>:p'),
\        'select-a': 'aq',  '*select-a-function*': 's:select_a_quote',
\        'select-i': 'iq',  '*select-i-function*': 's:select_i_quote'
\      }
\    })

" Misc.  "{{{1
let s:pair_chars = "['\"{([<]"

function! s:select_a_quote()
  return s:select_quote(0)
endfunction

function! s:select_i_quote()
  return s:select_quote(1)
endfunction

function! s:select_quote(inside)

  let line=line('.')

  if !search(s:pair_chars, 'b', line)
    call search(s:pair_chars, '', line)
  endif

  let char = getline('.')[col('.')-1]
  let pos1 = getpos('.')

  let pair_char = s:pair_char(char)
  if len(pair_char) == 1
    call search(pair_char, '', line)
  else
    normal %
  endif
  let pos2 = getpos('.')

  if pos1[2] > pos2[2]
    let [start_pos, end_pos] = [pos2, pos1]
  else
    let [start_pos, end_pos] = [pos1, pos2]
  endif

  if a:inside
    let start_pos[2] += 1
    let end_pos[2] -= 1
  endif

  return ['v', end_pos, start_pos]
endfunction

function! s:pair_char(char)
  if a:char == "\""
    return "\""
  elseif a:char == "'"
    return "'"
  elseif a:char == "<"
    return ">"
  else
    return ""
  endif
endfunction

" Fin.  "{{{1

let g:loaded_textobj_quoted = 1

" __END__
" vim: foldmethod=marker
