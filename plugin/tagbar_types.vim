let g:tagbar_type_coffee = {
      \ 'ctagstype' : 'coffee',
      \ 'kinds' : [
        \ 'm:functions',
        \ 'c:object',
      \ ],
      \ 'sro' : ".",
      \ 'kind2scope' : {
        \ 'm' : 'object',
        \ 'c' : 'object',
      \ }
\ }
if executable('crystal-tags')
  let g:tagbar_type_crystal = {
      \ 'ctagstype' : 'crystal',
      \ 'kinds'     : [
          \ 's:struct',
          \ 'c:class',
          \ 'm:module',
          \ 'f:method',
          \ 'l:library',
          \ 't:type'
      \ ],
      \ 'sro' : '.',
      \ 'kind2scope' : {
          \ 'c' : 'class',
          \ 'm' : 'module',
          \ 's' : 'struct',
          \ 'l' : 'library'
      \ },
      \ 'scope2kind' : {
          \ 'class' : 'c',
          \ 'module' : 'm',
          \ 'library': 'l'
      \ },
      \ 'ctagsbin'  : 'crystal-tags',
      \ 'ctagsargs' : '-f -'
  \ }
endif
let g:tagbar_type_scala = {
    \ 'ctagstype' : 'scala',
    \ 'kinds'     : [
        \ 'p:packages:1',
        \ 'V:values',
        \ 'v:variables',
        \ 'T:types',
        \ 't:traits',
        \ 'o:objects',
        \ 'a:aclasses',
        \ 'c:classes',
        \ 'r:cclasses',
        \ 'm:methods'
    \ ],
    \ 'sro' : ".",
    \ 'kind2scope' : {
        \ 'T' : 'type',
        \ 't' : 'trait',
        \ 'o' : 'object',
        \ 'a' : 'abstract class',
        \ 'c' : 'class',
        \ 'r' : 'case class'
    \ },
    \ 'scope2kind' : {
        \ 'type' : 'T',
        \ 'trait' : 't',
        \ 'object' : 'o',
        \ 'abstract class' : 'a',
        \ 'class' : 'c',
        \ 'case class' : 'r'
    \ },
\ }
let g:tagbar_type_elixir = {
    \ 'ctagstype' : 'elixir',
    \ 'kinds'     : [
        \ 'f:functions',
        \ 'c:callbacks',
        \ 'd:delegates',
        \ 'e:exceptions',
        \ 'i:implementations',
        \ 'a:macros',
        \ 'o:operators',
        \ 'm:modules',
        \ 'p:protocols',
        \ 'r:records'
    \ ],
    \ 'sro' : "."
\ }
let g:tagbar_type_rust = {
    \ 'ctagstype' : 'rust',
    \ 'kinds'     : [
        \ 'f:functions',
        \ 'T:types',
        \ 'g:enums',
        \ 's:structures',
        \ 'm:modules',
        \ 'c:constants',
        \ 't:traits',
        \ 'i:impls',
        \ 'd:macros',
    \ ],
    \ 'sro' : ".",
    \ 'kind2scope' : {
        \ 'i' : 'impl',
        \ 'm' : 'module',
        \ 't' : 'trait'
    \ },
    \ 'scope2kind' : {
        \ 'impl' : 'i',
        \ 'module' : 'm',
        \ 'trait' : 't',
    \ },
\ }
