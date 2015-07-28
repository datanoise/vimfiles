if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

let s:save_cpo = &cpo
set cpo&vim

if exists("loaded_matchit") && !exists("b:match_words")
  let b:match_ignorecase = 0

  let b:match_words =
        \ '\<\%(if\|unless\|case\|while\|until\|for\|do\|class\|module\|struct\|lib\|macro\|ifdef\|def\|fun\|begin\)\>=\@!' .
        \ ':' .
        \ '\<\%(else\|elsif\|ensure\|when\|rescue\|break\|redo\|next\|retry\)\>' .
        \ ':' .
        \ '\<end\>' .
        \ ',{:},\[:\],(:)'

  let b:match_skip =
        \ "synIDattr(synID(line('.'),col('.'),0),'name') =~ '" .
        \ "\\<crystal\\%(String\\|StringDelimiter\\|ASCIICode\\|Escape\\|" .
        \ "Interpolation\\|NoInterpolation\\|Comment\\|Documentation\\|" .
        \ "ConditionalModifier\\|RepeatModifier\\|OptionalDo\\|" .
        \ "Function\\|BlockArgument\\|KeywordAsMethod\\|ClassVariable\\|" .
        \ "InstanceVariable\\|GlobalVariable\\|Symbol\\)\\>'"
endif

setlocal comments=:#
setlocal commentstring=#\ %s
setlocal formatoptions+=roqct

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: nowrap sw=2 sts=2 ts=8:
