" File: maroloccio.vim

" Description: a colour scheme for Vim (GUI only)

" Scheme: maroloccio
" Maintainer: Marco Ippolito < m a r o l o c c i o [at] g m a i l . c o m >

" Comment: only works in GUI mode

" Version: v0.1.2, inspired by watermark
" Date: 11 December 2008
" History:
" 0.1.2 Fixed versioning system, added .vimrc -like commands
" 0.1.1 Corrected typo in header comments, changed colour for Comment
" 0.1.0 Inital upload to vim.org

" Show cursor position
" set cursorline
" set cursorcolumn

" Show line numbers
" set number
" set numberwidth=5

highlight clear
if exists("syntax_on")
  syntax reset
endif

let g:colors_name="maroloccio"

highlight  Normal        guifg=#8b9aaa  guibg=#1a202a  gui=none   "watermark

highlight  StatusLine    guifg=#8b9aaa  guibg=#0e1219             "maroloccio
highlight  TabLine       guifg=#8b9aaa  guibg=#0e1219             "maroloccio
highlight  Folded        guifg=#8b9aaa  guibg=#0e1219             "maroloccio
highlight  WildMenu      guifg=#8b9aaa  guibg=#0e1219             "maroloccio

highlight  LineNr        guifg=#2c3138  guibg=#0e1219  gui=italic "maroloccio
highlight  VertSplit     guifg=#2c3138  guibg=#0e1219             "maroloccio
highlight  StatusLineNC  guifg=#2c3138  guibg=#0e1219             "maroloccio

highlight  Visual        guifg=#1a202a  guibg=#8b9aaa             "maroloccio
highlight  PmenuSel      guifg=#1a202a  guibg=#8b9aaa             "maroloccio
highlight  Search        guifg=#1a202a  guibg=#8b9aaa             "maroloccio
highlight  IncSearch     guifg=#1a202a  guibg=#8b9aaa             "maroloccio

highlight  Cursor        guifg=#0e1219  guibg=#8b9aaa             "maroloccio

highlight  CursorLine    guibg=#0e1219  "guifg=                   "maroloccio
highlight  CursorColumn  guibg=#0e1219  "guifg=                   "maroloccio

highlight  NonText       guifg=#2c3138  "guibg=                   "maroloccio
highlight  SpecialKey    guifg=#2c3138  "guibg=                   "maroloccio

highlight  Pmenu         guifg=#8b9aaa  guibg=#2c3138             "maroloccio

highlight  Todo          guifg=#8f3231  guibg=#0e1219             "maroloccio
highlight  Todo          guisp=#cbc32a  gui=bold,italic,undercurl "maroloccio

highlight  Comment       guifg=#2680af  gui=italic     "blue2     "maroloccio

highlight  Constant      guifg=#82ade0  "guibg=        "cyan      "maroloccio
highlight  link          Constant       String
highlight  link          Constant       Character
highlight  link          Constant       Number
highlight  link          Constant       Boolean
highlight  link          Constant       Float

highlight  PreProc       guifg=#107040  gui=italic     "green     "maroloccio
highlight  link          PreProc        Include
highlight  link          PreProc        Define
highlight  link          PreProc        Macro
highlight  link          PreProc        PreCondit

highlight  Type          guifg=#cbc32a  gui=italic     "yellow    "maroloccio
highlight  link          Type           StorageClass
highlight  link          Type           Structure
highlight  link          Type           Typedef

highlight  Error         guifg=#8b9aaa  guibg=#8f3231  "red bkgr  "maroloccio
highlight  Error         gui=italic                               "maroloccio

highlight  Exception     guifg=#8f3231  gui=italic     "red       "maroloccio

highlight  Conditional   guifg=#d88e49  gui=italic     "orange    "maroloccio

highlight  Repeat        guifg=#78ba42  gui=italic     "lt green  "maroloccio

highlight  Statement     guifg=#9966ff  gui=italic     "lavender  "maroloccio

highlight  Label         guifg=#4e00c3  gui=italic     "purple    "maroloccio
highlight  Function      guifg=#4e00c3  gui=italic     "purple    "maroloccio
highlight  SpecialChar   guifg=#006666  gui=italic     "teal      "maroloccio

highlight  Operator      guifg=#6d5279  gui=italic     "pink      "maroloccio

highlight  Special       guifg=#3741ad  gui=italic     "blue      "maroloccio
highlight  link          Special        Tag
highlight  link          Special        Delimiter
highlight  link          Special        SpecialComment

highlight  Underlined    gui=bold,italic,underline     "underline "maroloccio

" highlight  Identifier
" highlight  Keyword
" highlight  Ignore
