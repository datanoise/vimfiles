" bufexplorer settings
if !has_key(g:plugs, 'vim-bclose')
  finish
end

nnoremap <silent> <leader>be :BufExplorer<CR>
nnoremap <silent> <leader>q :Bclose<CR>

