if exists("g:loaded_tmux_focus")
  finish
endif
let g:loaded_tmux_focus = 1

if !exists("$TMUX") || has('nvim')
  finish
endif

" TMUX Focus management
" if we run in tmux, focus events will trigger monitor-activity when
" leaving the active window. I find this quite annoying, so instead we
" disable this option in tmux for the current window and restore it upon
" the exit from Vim.
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
