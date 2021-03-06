if exists("g:loaded_iterm")
  finish
endif
let g:loaded_iterm = 1

if has('gui_running') || $TERM_PROGRAM != 'iTerm.app'
  finish
endif

" some handful mappings
if !has('nvim')
  execute "set <M-q>=\eq"
  execute "set <M-t>=\et"
  execute "set <Home>=\ea"
  execute "set <End>=\ee"
  execute "set <S-Left>=\eb"
  execute "set <S-Right>=\ef"
endif

" change the cursor shape based on the current mode
" unfortunately, any mappings in the insert mode that change mode
" will cause annoying cursor flickering. so disabling it for now.
if 0 && has('cursorshape')
  let &t_SI = "\<Esc>[3 q"
  let &t_EI = "\<Esc>[0 q"
endif

" allow iTerm to report FocusGained FocusLost events
let s:enable_focus_reporting = "\<Esc>[?1004h"
let s:disable_focus_reporting = "\<Esc>[?1004l"
let s:save_screen = "\<Esc>[?1049h"
let s:restore_screen = "\<Esc>[?1049l"

let &t_ti = &t_EI . s:enable_focus_reporting . s:save_screen
let &t_te = s:disable_focus_reporting . s:restore_screen

function s:DoCmdFocusLost()
  let cmd = getcmdline()
  let pos = getcmdpos()

  silent doautocmd <nomodeline> FocusLost %

  call setcmdpos(pos)
  return cmd
endfunction

function s:DoCmdFocusGained()
  let cmd = getcmdline()
  let pos = getcmdpos()

  silent doautocmd <nomodeline> FocusGained %

  call setcmdpos(pos)
  return cmd
endfunction

execute "set <f24>=\<Esc>[O"
execute "set <f25>=\<Esc>[I"

nnoremap <silent> <f24> :silent doautocmd <nomodeline> FocusLost %<cr>
nnoremap <silent> <f25> :silent doautocmd <nomodeline> FocusGained %<cr>

onoremap <silent> <f24> <esc>:silent doautocmd <nomodeline> FocusLost %<cr>
onoremap <silent> <f25> <esc>:silent doautocmd <nomodeline> FocusGained %<cr>

vnoremap <silent> <f24> <esc>:silent doautocmd <nomodeline> FocusLost %<cr>gv
vnoremap <silent> <f25> <esc>:silent doautocmd <nomodeline> FocusGained %<cr>gv

inoremap <silent> <f24> <c-\><c-o>:silent doautocmd <nomodeline> FocusLost %<cr>
inoremap <silent> <f25> <c-\><c-o>:silent doautocmd <nomodeline> FocusGained %<cr>

cnoremap <silent> <f24> <c-\>e<SID>DoCmdFocusLost()<cr>
cnoremap <silent> <f25> <c-\>e<SID>DoCmdFocusGained()<cr>

" if we run in tmux, focus events will trigger monitor-activity when
" leaving the active window. I find this quite annoying, so instead we
" disable this option in tmux for the current window and restore it upon
" the exit from Vim.
if 0 && exists("$TMUX")
  let s:g_monitor_activity = 0
  let s:w_monitor_activity = 0
  let s:w_monitor_activity_unset = 0

  if !exists('*job_start')
    let s:w_monitor_activity_val = system("tmux showw -v monitor-activity")
    if s:w_monitor_activity_val =~ "on"
      let s:w_monitor_activity = 1
    endif
    if s:w_monitor_activity_val == ""
      let s:w_monitor_activity_unset = 1
    endif
    if system("tmux showw -gv monitor-activity") =~ "on"
      let s:g_monitor_activity = 1
    endif

    if s:g_monitor_activity || s:w_monitor_activity
      call system("tmux setw monitor-activity off")
    endif
  else
    func! s:read_all_channel(channel)
      let buf = []
      while ch_status(a:channel) == 'buffered'
        call add(buf, ch_read(a:channel))
      endwhile
      return join(buf)
    endfunc

    func! s:on_w_monitor(channel)
      let result = s:read_all_channel(a:channel)
      if result =~ "on"
        let s:w_monitor_activity = 1
      endif
      if result == ""
        let s:w_monitor_activity_unset = 1
      endif
      call job_start("tmux showw -gv monitor-activity", {'close_cb': function('s:on_g_monitor')})
    endfunc

    func! s:on_g_monitor(channel)
      let result = s:read_all_channel(a:channel)
      if result =~ "on"
        let s:g_monitor_activity = 1
      endif

      if s:g_monitor_activity || s:w_monitor_activity
        call job_start("tmux setw monitor-activity off")
      endif
    endfunc
    call job_start("tmux showw -v monitor-activity", {'close_cb': function('s:on_w_monitor')})
  end

  au VimLeave *
        \ if s:g_monitor_activity || s:w_monitor_activity |
        \   if s:w_monitor_activity_unset |
        \     call system("tmux setw -u monitor-activity") |
        \   elseif s:w_monitor_activity |
        \     call system("tmux setw monitor-activity off") |
        \   endif |
        \ endif
endif
