"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File: "datanoise.vim"
" Created: "Thu, 23 May 2002 00:12:20 -0300 (caciano)"
" Updated: "Sat, 24 Aug 2002 14:04:21 -0300 (caciano)"
" Modified By: Kent Sibilev
" Copyright (C) 2002, Caciano Machado <caciano@inf.ufrgs.br>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colorscheme Option:
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
hi clear
if exists("syntax on")
    syntax reset
endif
let g:colors_name = "datanoise"

" General colors
hi Normal   ctermfg=gray guifg=peachpuff3 guibg=black
hi Conceal  ctermfg=gray guifg=#252525 guibg=black
hi Directory    term=bold ctermfg=blue guifg=royalblue
hi ErrorMsg term=standout ctermfg=white ctermbg=red guifg=white guibg=red3
hi SpellBad term=standout ctermfg=red guifg=red3
hi NonText  term=bold ctermfg=darkgray guibg=black guifg=gray20
hi SpecialKey   term=bold ctermfg=darkgray guifg=gray30
hi LineNr   term=underline ctermfg=darkgray guifg=ivory4 guibg=gray4
hi IncSearch    term=reverse cterm=reverse gui=reverse,bold guifg=darkgoldenrod2
hi Search   term=reverse ctermfg=black ctermbg=yellow guifg=gray10 guibg=gold2
hi Visual   term=bold,reverse cterm=bold,reverse ctermfg=gray ctermbg=black gui=bold,reverse guifg=gray40 guibg=black
hi VisualNOS    term=bold,underline cterm=bold,underline gui=bold,underline
hi MoreMsg  term=bold ctermfg=green gui=bold guifg=olivedrab1
hi ModeMsg  term=bold cterm=bold gui=bold
hi Question term=standout ctermfg=green gui=bold guifg=olivedrab1
hi WarningMsg   term=standout ctermfg=red gui=bold guifg=red3
hi WildMenu term=standout ctermfg=black ctermbg=yellow guifg=yellow guibg=black
hi Folded   term=standout ctermfg=blue ctermbg=darkgray guifg=royalblue1 guibg=#050505
hi FoldColumn   term=standout ctermfg=blue ctermbg=black guifg=royalblue3 guibg=black
hi DiffAdd      guifg=#ffffff       guibg=#126493       gui=NONE
            \   ctermfg=white       ctermbg=darkblue    cterm=NONE
hi DiffChange   guifg=royalblue4       guibg=black       gui=NONE
            \   ctermfg=black       ctermbg=darkmagenta cterm=NONE
hi DiffDelete   guifg=#000000       guibg=#000000       gui=NONE
            \   ctermfg=black       ctermbg=red         cterm=NONE
hi DiffText     guifg=#976398       guibg=black       gui=NONE
            \   ctermfg=white       ctermbg=green       cterm=NONE
hi Cursor   guifg=bg guibg=fg
hi lCursor  guifg=bg guibg=fg
hi CursorLine   guifg=NONE          guibg=#1b1b1b       gui=NONE
            \   ctermfg=NONE        ctermbg=NONE        cterm=NONE
hi! link CursorLine CursorLine
" hi StatusLine   term=reverse cterm=reverse gui=reverse guifg=gray60
" hi StatusLineNC term=reverse cterm=reverse gui=reverse guifg=gray40
hi StatusLine   guifg=#CCCCCC       guibg=#202020       gui=none
            \   ctermfg=white       ctermbg=darkgray    cterm=NONE
hi StatusLineNC guifg=black         guibg=#202020       gui=NONE
            \   ctermfg=blue        ctermbg=darkgray    cterm=NONE
hi SignColumn   guifg=#c8bcb9       guibg=#202020       gui=none
            \   ctermfg=lightgray   ctermbg=darkgray    cterm=NONE
" hi VertSplit    term=reverse cterm=reverse gui=bold,reverse guifg=gray40
hi VertSplit   guifg=#CCCCCC       guibg=#202020       gui=none
            \   ctermfg=white       ctermbg=darkgray    cterm=NONE
hi Title    term=bold ctermfg=magenta gui=bold guifg=aquamarine
hi TabLine      guifg=#000000       guibg=#c2bfa5       gui=NONE
            \   ctermfg=black       ctermbg=white       cterm=NONE
hi TabLineFill  guifg=#000000       guibg=#c2bfa5       gui=NONE
            \   ctermfg=black       ctermbg=white       cterm=NONE
hi TabLineSel   guifg=#ffffff       guibg=#133293       gui=NONE
            \   ctermfg=white       ctermbg=black       cterm=NONE
hi PmenuSbar    guifg=NONE          guibg=#555555       gui=NONE
            \   ctermfg=black       ctermbg=black       cterm=NONE
hi PmenuThumb   guifg=NONE          guibg=#cccccc       gui=NONE
            \   ctermfg=gray        ctermbg=gray        cterm=NONE
hi Pmenu        guifg=#f6f3e8       guibg=#444444       gui=NONE
            \   ctermfg=NONE        ctermbg=NONE        cterm=NONE
hi PmenuSel     guifg=#000000       guibg=#cae682       gui=NONE
            \   ctermfg=NONE        ctermbg=NONE        cterm=NONE

" syntax hi colors
" hi Comment  term=bold ctermfg=darkcyan guifg=cyan4
hi Comment  term=bold ctermfg=darkcyan guifg=#8b8989
hi PreProc  term=underline ctermfg=darkblue guifg=dodgerblue4
hi Constant term=underline ctermfg=darkred guifg=firebrick3
hi Type     term=underline ctermfg=darkgreen gui=none guifg=chartreuse3
hi Statement    term=bold ctermfg=darkyellow gui=none guifg=gold3
hi Identifier   term=underline ctermfg=darkgreen guifg=darkolivegreen4
hi Ignore   term=bold ctermfg=darkgray guifg=gray45
hi Special  term=underline ctermfg=brown guifg=sienna
hi Error    term=reverse ctermfg=gray ctermbg=red guifg=gray guibg=red3
hi Todo     term=standout ctermfg=black ctermbg=yellow gui=bold guifg=gray10 guibg=yellow4
hi Underlined   term=underline cterm=underline ctermfg=darkblue gui=underline guifg=slateblue
hi Number   term=underline ctermfg=darkred guifg=red2
hi Symbol guifg=#ff6050 guibg=NONE gui=NONE
" syntax hi links
hi link String      Constant
hi link Character   Constant
hi link Number      Constant
hi link Boolean     Constant
hi link Float       Number
hi link Function    Identifier
hi link Conditional Statement
hi link Repeat      Statement
hi link Label       Statement
hi link Keyword     Statement
hi link Exception   Statement
hi link Operator    Statement
hi link Include     PreProc
hi link Define      PreProc
hi link Macro       PreProc
hi link PreCondit   PreProc
hi link StorageClass    Type
hi link Structure   Type
hi link Typedef     Type
hi link Tag     Special
hi link SpecialChar Special
hi link Delimiter   Special
hi link SpecialComment  Special
hi link Debug       Special
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
hi link rubySymbol Symbol
hi link elixirAtom  Symbol
hi link jsObjectKey Symbol
hi link htmlLink Normal
hi link htmlItalic Normal
hi link goDirective Define
hi link goDeclaration Define
hi link goField Identifier
hi link goMethod Function
