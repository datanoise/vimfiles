" Vim syntax file
" Language:     Rack Builder language
" Maintainer:   Daniel Schierbeck <daniel.schierbeck@gmail.com>
" Last Change:  2008 Dec 18

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

if !exists("main_syntax")
  let main_syntax = 'html'
endif

if version < 600
  so <sfile>:p:h/ruby.vim
else
  runtime! syntax/ruby.vim
  unlet b:current_syntax
endif

syn keyword rackKeyword use map run

hi link rackKeyword Keyword
