if not vim.g.plugs['nvim-bqf'] then
    return
end

require("bqf").setup({
    preview = {
        auto_preview = false,
    },
})
