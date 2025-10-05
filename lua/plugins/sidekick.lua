if not vim.g.plugs['sidekick.nvim'] then
    return
end

require("sidekick").setup({
    cli = {
        mux = {
            backend = "tmux",
            enabled = true,
        }
    }
})

vim.g.sidekick_nes = false

vim.keymap.set("n", "<Tab>", function()
    -- if there is a next edit, jump to it, otherwise apply it if any
    if not require("sidekick").nes_jump_or_apply() then
        return "<Tab>" -- fallback to normal tab
    end
end, { expr = true, desc = "Goto/Apply Next Edit Suggestion" })
vim.keymap.set("n", "<leader>aa", function()
    require("sidekick.cli").toggle({ focus = true })
end, { desc = "Sidekick Toggle CLI" })
vim.keymap.set("n", "<leader>ac", function()
    require("sidekick.cli").toggle({ name = "claude", focus = true })
end, { desc = "Sidekick Claude Toggle" })
vim.keymap.set("n", "<leader>al", function()
    require("sidekick.cli").toggle({ name = "copilot", focus = true })
end, { desc = "Sidekick Copilot Toggle" })
vim.keymap.set("n", "<leader>ap", function()
    require("sidekick.cli").select_prompt()
end, { desc = "Sidekick Ask Prompt" })
