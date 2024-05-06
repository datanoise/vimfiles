if not vim.g.plugs['oil.nvim'] then
    return
end

require("oil").setup()

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
