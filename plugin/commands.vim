" Commands
" ------------------------------------------------------------------------------
" NOTE: that doesn't work in MacVim gui mode if sudo requests a password!!!
command! -bar -nargs=0 SudoW   :exe "write !sudo tee % >/dev/null"|silent edit!
command! -bang -nargs=1 -complete=file QFilter call s:filter_quickfix(<bang>0, <q-args>)
" borrowed from tpope's plugin
augroup shebang_chmod
  au!
  au BufWritePre *
        \   if getline(1) =~ '^#![\@!' && match(getfperm(expand('<afile>')), 'x') == -1 |
        \     let b:chmod_post = '+x' |
        \   endif |
  au BufWritePost,FileWritePost *
        \ if exists('b:chmod_post') && executable('chmod') |
        \   silent! execute '!chmod '.b:chmod_post.' "<afile>"' |
        \   unlet b:chmod_post |
        \ endif
augroup END
" this incompatible with oil.nvim plugin
" augroup auto_create_directory
"   au!
"   au BufWritePre *
"         \  let d=expand("<afile>:h") |
"         \  if !isdirectory(d) |
"         \    call mkdir(d, 'p') |
"         \  endif |
"         \  unlet d
" augroup END
if has_key(g:plugs, 'exception.vim')
  command! WTF call exception#trace()
endif
