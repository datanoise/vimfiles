" bufexplorer settings
if has('nvim')
  finish
endif

if !has_key(g:plugs, 'bufexplorer.zip')
  finish
end

nnoremap <silent> <leader>be :BufExplorer<CR>
