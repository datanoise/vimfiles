" gitgutter settings
if !has_key(g:plugs, 'vim-gitgutter')
  finish
endif

let g:gitgutter_enabled = 1
let g:gitgutter_override_sign_column_highlight = 0
nnoremap <leader>ge :GitGutterEnable<CR>
nnoremap <leader>gg :GitGutterToggle<CR>

