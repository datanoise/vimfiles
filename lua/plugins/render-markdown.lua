if not vim.g.plugs['render-markdown.nvim'] then
    return
end

require('render-markdown').setup({
    file_types = { 'markdown', 'codecompanion' },
})
