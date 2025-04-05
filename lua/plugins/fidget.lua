if not vim.g.plugs['fidget.nvim'] then
    return
end

require"fidget".setup({
    notification = {
        window = {
            winblend = 0,
            -- border = "rounded",
        },
    }
})
