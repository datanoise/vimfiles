" Vim additional ftplugin: ruby/textobj-function
" Version 0.1.0
" Copyright (C) 2007-2009 Kent Sibilev

if !exists('*g:textobj_function_ruby_select')
  function! g:textobj_function_ruby_select(object_type)
    return s:select_{a:object_type}()
  endfunction

  function! s:select_a()
    if line('.') != '}'
      normal ]M
    endif
    let e = getpos('.')
    normal [m
    let b = getpos('.')

    if 1 < e[1] - b[1]  " is ther some code?
      return ['V', b, e]
    else
      return 0
    endif
  endfunction

  function! s:select_i()
    if line('.') != '}'
      normal ]M
    endif
    let e = getpos('.')
    normal [m
    let b = getpos('.')

    if 1 < e[1] - b[1]  " is ther some code?
      call setpos('.', b)
      normal! j0
      let b = getpos('.')
      call setpos('.', e)
      normal! k$
      let e = getpos('.')
      return ['V', b, e]
    else
      return 0
    endif
  endfunction
endif




let b:textobj_function_select = function('g:textobj_function_ruby_select')




if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= '|'
else
  let b:undo_ftplugin = ''
endif
let b:undo_ftplugin .= 'unlet b:textobj_function_select'

" __END__
" vim: foldmethod=marker
