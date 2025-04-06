if not vim.g.plugs['oil.nvim'] then
    return
end

require("oil").setup({
    float = {
        padding = 2,
        max_width = 0.5,
        max_height = 0.5,
        border = "rounded",
    },
    keymaps = {
        ["q"] = { "actions.close", mode = "n" }
    }
})

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set("n", "g-", function() require'oil'.toggle_float() end, { desc = "Toggle parent directory" })
