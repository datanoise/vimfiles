" ale settings
if !has_key(g:plugs, 'ale')
  finish
endif

set signcolumn=yes
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_rust_cargo_use_check = 1
let g:ale_rust_rls_toolchain = 'stable'
let g:ale_set_highlights = 0
let g:ale_ruby_rubocop_executable='bundle'
let g:ale_linters = {
      \ 'ruby': ['ruby', 'rubocop'],
      \ 'rust': ['cargo'],
      \ 'go': ['go build', 'govet'],
      \ 'javascript': ['eslint'],
      \ }
let g:ale_fixers = {
      \ 'ruby': ['rubocop']
      \ }
nmap <silent> [W <Plug>(ale_first)
nmap <silent> [w <Plug>(ale_previous)
nmap <silent> ]w <Plug>(ale_next)
nmap <silent> ]W <Plug>(ale_last)
" ale autocompletion is not ready for the prime time yet
" let g:ale_completion_enabled = 1
" let g:ale_completion_experimental_lsp_support = 1
" let g:ale_completion_delay = 1000
let g:ale_virtualtext_cursor = 1
let g:ale_virtualtext_delay = 5
" disable ruby lint if coc.vim lsp capability is enabled
let g:ale_pattern_options = {
\   '.*\.rb$': {'ale_enabled': 0},
\}
