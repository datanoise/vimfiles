function! s:TailTestTerminal(bufnr, timer) abort
  if !bufexists(a:bufnr)
    call timer_stop(a:timer)
    return
  endif

  let l:winid = bufwinid(a:bufnr)
  if l:winid != -1
    call win_execute(l:winid, 'silent keepjumps normal! G', 1)
  endif
endfunction

function! s:WrappedCommand(cmd, tempfile, statusfile) abort
  let l:tempfile = shellescape(a:tempfile)
  let l:statusfile = shellescape(a:statusfile)

  return '{ { ' . a:cmd . '; printf "%s" $? > ' . l:statusfile . '; } 2>&1 | tee ' . l:tempfile . '; } ; exit $(cat ' . l:statusfile . ')'
endfunction

function! s:QuickfixCommand(cmd) abort
  let l:cmd = a:cmd

  while l:cmd =~# '^\s*[A-Za-z_][A-Za-z0-9_]*=\S\+\s\+'
    let l:cmd = substitute(l:cmd, '^\s*[A-Za-z_][A-Za-z0-9_]*=\S\+\s\+', '', '')
  endwhile
  let l:cmd = substitute(l:cmd, '^\s*bundle\s\+exec\s\+', '', '')
  let l:cmd = substitute(l:cmd, '^\s*\%(\./\)\?bin/\(rspec\|rake\|ruby\|rails\)\>', '\1', '')

  return l:cmd
endfunction

function! s:QuickfixCompiler(cmd) abort
  if a:cmd =~# '^\s*rails\>\s\+test\>'
    return 'rubyunit'
  endif
  if a:cmd =~# '^\s*\%(.\{-}/\)\=rspec\>'
    return 'rspec'
  endif
  if exists('*dispatch#compiler_for_program')
    return dispatch#compiler_for_program(a:cmd)
  endif
  return ''
endfunction

function! s:RailsTestErrorFormat() abort
  return join([
        \ '%EFailure:',
        \ '%EError:',
        \ '%C%*[^[][%f:%l]:',
        \ '%Z%m',
        \ '%-G%.%#',
        \ ], ',')
endfunction

function! s:PopulateQuickfix(cmd, tempfile) abort
  let l:makeprg = &l:makeprg
  let l:errorformat = &l:errorformat
  let l:compiler = get(b:, 'current_compiler', '')
  let l:cmd = s:QuickfixCommand(a:cmd)
  let l:qf_compiler = ''

  try
    let l:qf_compiler = s:QuickfixCompiler(l:cmd)
    if !empty(l:qf_compiler)
      execute 'compiler ' . l:qf_compiler
    endif

    if l:cmd =~# '^\s*rails\>\s\+test\>'
      let &l:errorformat = s:RailsTestErrorFormat()
    endif

    let &l:makeprg = l:cmd
    execute 'silent noautocmd cgetfile ' . fnameescape(a:tempfile)
  finally
    let &l:makeprg = l:makeprg
    let &l:errorformat = l:errorformat
    if empty(l:compiler)
      unlet! b:current_compiler
    else
      let b:current_compiler = l:compiler
    endif
  endtry
endfunction

function! s:CloseTestTerminal(bufnr, cmd, tempfile, statusfile, job_id, exit_code, event) abort
  let l:timer = getbufvar(a:bufnr, 'test_tail_timer', -1)
  if l:timer != -1
    call timer_stop(l:timer)
    call setbufvar(a:bufnr, 'test_tail_timer', -1)
  endif

  if bufexists(a:bufnr)
    let l:winid = bufwinid(a:bufnr)
    if l:winid != -1
      call win_execute(l:winid, 'silent! bdelete!', 1)
    else
      execute 'silent! bdelete! ' . a:bufnr
    endif
  endif

  if a:exit_code == 0
    cclose
    echohl ModeMsg
    echom 'Success'
    echohl NONE
  else
    call s:PopulateQuickfix(a:cmd, a:tempfile)
    botright copen
  endif

  call delete(a:tempfile)
  call delete(a:statusfile)
endfunction

function! test#datanoise#vim_test_strategy(cmd) abort
  let l:source_win = win_getid()
  let l:term_position = get(g:, 'test#neovim#term_position', 'botright 10')
  let l:tempfile = tempname()
  let l:statusfile = tempname()
  let l:wrapped = s:WrappedCommand(a:cmd, l:tempfile, l:statusfile)

  call writefile([], l:tempfile)
  call writefile([], l:statusfile)

  execute l:term_position . ' new'
  let l:term_buf = bufnr('%')
  let l:term_win = win_getid()
  call termopen(l:wrapped, {
        \ 'on_exit': function('s:CloseTestTerminal', [l:term_buf, a:cmd, l:tempfile, l:statusfile]),
        \ })
  call setbufvar(l:term_buf, 'test_tail_timer', timer_start(100, function('s:TailTestTerminal', [l:term_buf]), { 'repeat': -1 }))
  call win_execute(l:term_win, 'silent keepjumps normal! G', 1)

  call win_gotoid(l:source_win)
endfunction
