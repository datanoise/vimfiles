" rubycomplete plugin settings {{{2
let g:rubycomplete_buffer_loading    = 1
let g:rubycomplete_rails             = 0
let g:rubycomplete_classes_in_global = 1

" A settings {{{2
let g:alternateExtensions_h = 'c,cpp,cxx,cc,CC,m,mm'
let g:alternateExtensions_m = 'h'
let g:alternateExtensions_mm = 'h'

" python-mode settings {{{2
let g:pymode_options = 0
let g:pymode_python = 'python3'
let g:pymode_rope = 0
let g:pymode_lint = 0
let g:pymode_lint_on_write = 0

" vim-plug settings {{{2
let g:plug_window = 'tabnew'
let g:plug_pwindow = 'below new'

" delimitMate settings {{{2
let g:delimitMate_expand_space = 1
let g:delimitMate_matchpairs = '(:),[:],{:}'

" Misc settings {{{2
let ruby_pseudo_operators = 1
let g:c_comment_strings = 1 " I like highlighting strings inside C comments
let g:xml_syntax_folding = 1 " enable folding in xml files
let g:racer_cmd = 'racer'
let g:vim_jsx_pretty_colorful_config = 1
let g:filetype_m = 'objc' " always open *.m files with objc filetype
let g:markdown_composer_autostart = 0
let g:vimtex_compiler_progname = 'nvr'
let g:tex_flavor = 'latex'
let g:ruby_heredoc_syntax_filetypes = {
      \ "xml": {
      \   "start": "XML"
      \ },
      \ "html": {
      \   "start": "HTML"
      \ },
      \ "sql": {
      \   "start": "SQL"
      \ },
      \}

if has('nvim') && exists('$SYSTEM_PYTHON')
  let g:python3_host_prog = $SYSTEM_PYTHON
endif

