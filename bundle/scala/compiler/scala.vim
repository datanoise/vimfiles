" Vim compiler file
" Compiler:     scalac
" Maintainer:   Kent Sibilev
" Last Change:  2009-04-09

if exists("current_compiler")
  finish
endif
let current_compiler = "scalac"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeprg=fsc

CompilerSet errorformat=%E%f:%l:\ %m,%-Z%p^,%-C%.%#,%-G%.%#
