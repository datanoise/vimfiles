" Vim color file -- candycode
" Maintainer:   Justin Constantino <goflyapig-at-gmail-com>
" Last Change:  2006 Aug 12

set background=dark
highlight clear
let g:colors_name="candycode_mod"

let save_cpo = &cpo
set cpo&vim

" basic highlight groups (:help highlight-groups) {{{

" text {{{

hi Normal       guifg=#f6f3e8       guibg=#050505       gui=NONE
            \   ctermfg=white       ctermbg=black       cterm=NONE

hi Conceal      guifg=#f6f3e8       guibg=#050505       gui=NONE
            \   ctermfg=white       ctermbg=black       cterm=NONE

hi Folded       guifg=#c2bfa5       guibg=#050505       gui=NONE
            \   ctermfg=lightgray   ctermbg=black       cterm=NONE

hi LineNr       guifg=#928c75       guibg=NONE          gui=NONE
            \   ctermfg=darkgray    ctermbg=NONE        cterm=NONE

hi Directory    guifg=#00bbdd       guibg=NONE          gui=NONE
            \   ctermfg=cyan        ctermbg=NONE        cterm=NONE
hi NonText      guifg=#77ff22       guibg=NONE          gui=NONE
            \   ctermfg=yellow      ctermbg=NONE        cterm=NONE
hi SpecialKey   guifg=#559933       guibg=NONE          gui=NONE
            \   ctermfg=green       ctermbg=NONE        cterm=NONE

hi SpellBad     guifg=NONE          guibg=NONE          gui=undercurl
            \   ctermfg=white       ctermbg=darkred     guisp=#ff0011
hi SpellCap     guifg=NONE          guibg=NONE          gui=undercurl
            \   ctermfg=white       ctermbg=darkblue    guisp=#0044ff
hi SpellLocal   guifg=NONE          guibg=NONE          gui=undercurl
            \   ctermfg=black       ctermbg=cyan        guisp=#00dd99
hi SpellRare    guifg=NONE          guibg=NONE          gui=undercurl
            \   ctermfg=white       ctermbg=darkmagenta guisp=#ff22ee

hi DiffAdd      guifg=#ffffff       guibg=#126493       gui=NONE
            \   ctermfg=white       ctermbg=darkblue    cterm=NONE
hi DiffChange   guifg=#000000       guibg=#976398       gui=NONE
            \   ctermfg=black       ctermbg=darkmagenta cterm=NONE
hi DiffDelete   guifg=#000000       guibg=#be1923       gui=NONE
            \   ctermfg=black       ctermbg=red         cterm=NONE
hi DiffText     guifg=#ffffff       guibg=#976398       gui=NONE
            \   ctermfg=white       ctermbg=green       cterm=NONE

" }}}
" borders / separators / menus {{{

hi FoldColumn   guifg=#c8bcb9       guibg=#202020       gui=NONE
            \   ctermfg=lightgray   ctermbg=darkgray    cterm=NONE
hi SignColumn   guifg=#c8bcb9       guibg=#202020       gui=none
            \   ctermfg=lightgray   ctermbg=darkgray    cterm=NONE

hi PmenuSbar    guifg=NONE          guibg=#555555       gui=NONE
            \   ctermfg=black       ctermbg=black       cterm=NONE
hi PmenuThumb   guifg=NONE          guibg=#cccccc       gui=NONE
            \   ctermfg=gray        ctermbg=gray        cterm=NONE
hi Pmenu        guifg=#f6f3e8       guibg=#444444       gui=NONE
            \   ctermfg=NONE        ctermbg=NONE        cterm=NONE
hi PmenuSel     guifg=#000000       guibg=#cae682       gui=NONE
            \   ctermfg=NONE        ctermbg=NONE        cterm=NONE

hi StatusLine   guifg=#CCCCCC       guibg=#202020       gui=none
            \   ctermfg=white       ctermbg=darkgray    cterm=NONE
hi StatusLineNC guifg=black         guibg=#202020       gui=NONE
            \   ctermfg=blue        ctermbg=darkgray    cterm=NONE
hi WildMenu     guifg=#ffffff       guibg=#133293       gui=NONE
            \   ctermfg=white       ctermbg=darkblue    cterm=NONE
hi VertSplit   guifg=#CCCCCC       guibg=#202020       gui=none
            \   ctermfg=white       ctermbg=darkgray    cterm=NONE
hi! link ColorColumn StatusLine

hi TabLine      guifg=#000000       guibg=#c2bfa5       gui=NONE
            \   ctermfg=black       ctermbg=white       cterm=NONE
hi TabLineFill  guifg=#000000       guibg=#c2bfa5       gui=NONE
            \   ctermfg=black       ctermbg=white       cterm=NONE
hi TabLineSel   guifg=#ffffff       guibg=#133293       gui=NONE
            \   ctermfg=white       ctermbg=black       cterm=NONE

"hi Menu
"hi Scrollbar
"hi Tooltip

" }}}
" cursor / dynamic / other {{{

hi Cursor       guifg=#000000       guibg=#ffff99       gui=NONE
            \   ctermfg=black       ctermbg=white       cterm=NONE
hi CursorIM     guifg=#000000       guibg=#aaccff       gui=NONE
            \   ctermfg=black       ctermbg=white       cterm=reverse
hi CursorLine   guifg=NONE          guibg=#1b1b1b       gui=NONE
            \   ctermfg=NONE        ctermbg=NONE        cterm=NONE
hi CursorColumn guifg=NONE          guibg=#1b1b1b       gui=NONE
            \   ctermfg=NONE        ctermbg=NONE        cterm=NONE

hi Visual       guifg=#ffffff       guibg=#606070       gui=NONE
            \   ctermfg=white       ctermbg=lightblue   cterm=NONE

hi IncSearch    guifg=#000000       guibg=#eedd33       gui=NONE
            \   ctermfg=white       ctermbg=yellow      cterm=NONE
hi Search       guifg=#efefd0       guibg=#937340       gui=NONE
            \   ctermfg=white       ctermbg=darkgreen   cterm=NONE

hi MatchParen   guifg=NONE          guibg=#3377aa       gui=NONE
            \   ctermfg=white       ctermbg=blue        cterm=NONE

"hi VisualNOS

" }}}
" listings / messages {{{

hi ModeMsg      guifg=#eecc18       guibg=NONE          gui=NONE
            \   ctermfg=yellow      ctermbg=NONE        cterm=NONE
hi Title        guifg=#dd4452       guibg=NONE          gui=NONE
            \   ctermfg=red         ctermbg=NONE        cterm=NONE
hi Question     guifg=#66d077       guibg=NONE          gui=NONE
            \   ctermfg=green       ctermbg=NONE        cterm=NONE
hi MoreMsg      guifg=#39d049       guibg=NONE          gui=NONE
            \   ctermfg=green       ctermbg=NONE        cterm=NONE

hi ErrorMsg     guifg=#ffffff       guibg=#ff0000       gui=NONE
            \   ctermfg=white       ctermbg=red         cterm=NONE
hi WarningMsg   guifg=white         guibg=#FF6C60       gui=BOLD
            \   ctermfg=white       ctermbg=red         cterm=NONE

" }}}

" }}}
" syntax highlighting groups (:help group-name) {{{

hi Comment      guifg=#ff9922       guibg=NONE          gui=NONE
            \   ctermfg=brown       ctermbg=NONE        cterm=NONE

hi Constant     guifg=#ff6050       guibg=NONE          gui=NONE
            \   ctermfg=red         ctermbg=NONE        cterm=NONE

hi Boolean      guifg=#ff6050       guibg=NONE          gui=NONE
            \   ctermfg=red         ctermbg=NONE        cterm=NONE

hi Identifier   guifg=#f7e396       guibg=NONE          gui=NONE
            \   ctermfg=yellow      ctermbg=NONE        cterm=NONE

hi Function     guifg=#eecc44       guibg=NONE          gui=NONE
            \   ctermfg=yellow      ctermbg=NONE        cterm=NONE

hi Statement    guifg=#66d077       guibg=NONE          gui=NONE
            \   ctermfg=green       ctermbg=NONE        cterm=NONE

hi PreProc      guifg=#bb88dd       guibg=NONE          gui=NONE
            \   ctermfg=darkmagenta ctermbg=NONE        cterm=NONE

hi Type         guifg=#4093cc       guibg=NONE          gui=NONE
            \   ctermfg=lightblue   ctermbg=NONE        cterm=NONE

hi Special      guifg=#9999aa       guibg=NONE          gui=NONE
            \   ctermfg=lightgray   ctermbg=NONE        cterm=NONE

hi Underlined   guifg=#80a0ff       guibg=NONE          gui=underline
            \   ctermfg=NONE        ctermbg=NONE        cterm=underline
            \   term=underline

hi Ignore       guifg=#888888       guibg=NONE          gui=NONE
            \   ctermfg=darkgray    ctermbg=NONE        cterm=NONE

hi Error        guifg=#ffffff       guibg=#ff0000       gui=NONE
            \   ctermfg=white       ctermbg=red         cterm=NONE

hi Todo         guifg=#ffffff       guibg=#ee7700       gui=NONE
            \   ctermfg=black       ctermbg=yellow      cterm=NONE

hi rubySymbol     guifg=#FFA16E  guibg=NONE          gui=NONE
            \   ctermfg=red         ctermbg=NONE        cterm=NONE

hi XPTIgnoredMark
            \   guifg=#CCCCCC       guibg=#202020       gui=NONE
            \   ctermfg=white       ctermbg=yellow      cterm=NONE

hi TemplateItem
            \   ctermbg=black gui=none guifg=white guibg=black

hi TemplateMark
            \   ctermbg=black gui=none guifg=white guibg=black

hi CommandTCharMatched ctermfg=red  ctermbg=NONE guifg=#ff0000 guibg=NONE

hi CommandTCharMatchedSel       guifg=#ff0000       guibg=#606070       gui=NONE
            \   ctermfg=red       ctermbg=lightblue   cterm=NONE
" }}}

let &cpo = save_cpo

" vim: fdm=marker fdl=99
