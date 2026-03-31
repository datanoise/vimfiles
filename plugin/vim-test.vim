" vim-test settings
if !has_key(g:plugs, 'vim-test')
  finish
endif

" Custom terminal strategy:
" - runs tests in a bottom Neovim terminal split
" - keeps output scrolling while the job runs
" - closes the terminal on exit
" - echoes "Success" on pass
" - opens quickfix on failure
"let g:test#strategy = 'nvim_term_autoclose'
"let g:test#custom_strategies = get(g:, 'test#custom_strategies', {})
"let g:test#custom_strategies.nvim_term_autoclose = function('test#datanoise#vim_test_strategy')

let g:test#strategy = 'dispatch'

let g:test#neovim#term_position = 'botright 10'

nnoremap <leader>ts :TestSuite<CR>
nnoremap <leader>tt :TestSuite<CR>
nnoremap <leader>tn :TestNearest<CR>
nnoremap <leader>tt :TestNearest<CR>
nnoremap <leader>tl :TestLast<CR>
nnoremap <leader>tf :TestFile<CR>
nnoremap <leader>tv :TestVisit<CR>

let g:test#ruby#use_binstubs = 1
