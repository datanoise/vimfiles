" bufexplorer settings
if !has_key(g:plugs, 'bufexplorer.zip')
  finish
end

nnoremap <silent> <leader>be :BufExplorer<CR>

