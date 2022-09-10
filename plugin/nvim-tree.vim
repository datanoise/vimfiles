if !has_key(g:plugs, 'nvim-tree.lua')
  finish
endif

lua require("nvim-tree").setup({view = {mappings = {list = {key = "<C-i>", action = "toggle_file_info"}}}, remove_keymaps = { "<C-k>" }})

nnoremap <silent> <leader>ft :NvimTreeToggle<CR>
nnoremap <silent> <leader>ff :NvimTreeFindFile<CR>
