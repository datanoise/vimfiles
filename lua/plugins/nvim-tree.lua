if not vim.g.plugs['nvim-tree.lua'] then
    return
end

require("nvim-tree").setup({
    actions = {open_file = { quit_on_open = true }},
    view = {
        mappings = {
            list = {key = "<C-i>", action = "toggle_file_info"}
        }
    },
    remove_keymaps = { "<C-k>" }
})

vim.cmd([[
nnoremap <silent> <leader>ft :NvimTreeToggle<CR>
nnoremap <silent> <leader>fd :NvimTreeToggle %:p:h<CR>
nnoremap <silent> <leader>ff :NvimTreeFindFile<CR>
]])
