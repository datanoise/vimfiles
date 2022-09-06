" telescope settings {{{2
if !has_key(g:plugs, 'telescope.nvim')
  finish
endif

lua require('plugins/telescope')

nnoremap <silent> <leader>T :Telescope<CR>
nnoremap <silent> <leader>; :Telescope<CR>
nnoremap <silent> <leader>l :Telescope buffers<CR>
nnoremap <silent> <leader>m :Telescope find_files<CR>
nnoremap <silent> <leader>F :Telescope find_files search_dirs=%:h<CR>
nnoremap <silent> <leader>e :Telescope oldfiles<CR>
nnoremap <silent> <leader>n :Telescope aerial theme=dropdown<CR>

