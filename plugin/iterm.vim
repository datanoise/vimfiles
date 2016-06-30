if exists("g:loaded_iterm")
  finish
endif
let g:loaded_iterm = 1
" change the cursor shape based on the current mode
" unfortunately, any mappings in the insert mode that change mode
" will cause annoying cursor flickering. so disabling it for now.
if 0 && !has('gui_running') && has('cursorshape') && $TERM_PROGRAM == 'iTerm.app'
  if exists('$TMUX')
    let &t_SI = "\<Esc>[3 q"
    let &t_EI = "\<Esc>[0 q"
  else
    let &t_SI = "\<Esc>]50;CursorShape=2\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
  endif
endif
" allow iTerm to report FocusGained FocusLost events
" unfortunately, this leaving the window in tmux will
" trigger monitor activity on it.
if !has('gui_running') && $TERM_PROGRAM == 'iTerm.app'
  let s:enable_focus_reporting = "\<Esc>[?1004h"
  let s:disable_focus_reporting = "\<Esc>[?1004l"
  let s:save_screen = "\<Esc>[?1049h"
  let s:restore_screen = "\<Esc>[?1049l"

  let &t_ti = &t_EI . s:enable_focus_reporting . s:save_screen
  let &t_te = s:disable_focus_reporting . s:restore_screen

  function s:DoCmdFocusLost()
    let cmd = getcmdline()
    let pos = getcmdpos()

    silent doautocmd FocusLost %

    call setcmdpos(pos)
    return cmd
  endfunction

  function s:DoCmdFocusGained()
    let cmd = getcmdline()
    let pos = getcmdpos()

    silent doautocmd FocusGained %

    call setcmdpos(pos)
    return cmd
  endfunction

  execute "set <f24>=\<Esc>[O"
  execute "set <f25>=\<Esc>[I"

  nnoremap <silent> <f24> :silent doautocmd FocusLost %<cr>
  nnoremap <silent> <f25> :silent doautocmd FocusGained %<cr>

  onoremap <silent> <f24> <esc>:silent doautocmd FocusLost %<cr>
  onoremap <silent> <f25> <esc>:silent doautocmd FocusGained %<cr>

  vnoremap <silent> <f24> <esc>:silent doautocmd FocusLost %<cr>gv
  vnoremap <silent> <f25> <esc>:silent doautocmd FocusGained %<cr>gv

  inoremap <silent> <f24> <c-o>:silent doautocmd FocusLost %<cr>
  inoremap <silent> <f25> <c-o>:silent doautocmd FocusGained %<cr>

  cnoremap <silent> <f24> <c-\>e<SID>DoCmdFocusLost()<cr>
  cnoremap <silent> <f25> <c-\>e<SID>DoCmdFocusGained()<cr>
endif
