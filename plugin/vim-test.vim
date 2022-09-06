" vim-test settings
if !has_key(g:plugs, 'vim-test')
  finish
endif

let g:test#strategy = 'dispatch'
nnoremap <leader>ts :TestSuite<CR>
nnoremap <leader>tt :TestSuite<CR>
nnoremap <leader>tn :TestNearest<CR>
nnoremap <leader>tt :TestNearest<CR>
nnoremap <leader>tl :TestLast<CR>
nnoremap <leader>tf :TestFile<CR>
nnoremap <leader>tv :TestVisit<CR>

