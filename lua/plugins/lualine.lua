if not vim.g.plugs['lualine.nvim'] then
    return
end

require('lualine').setup({
    sections = {
        lualine_c = { { 'filename', path = 1 }, },
        lualine_x = { { 'aerial', sep = " ", colored = true }, },
        lualine_y = { 'filetype', },
        lualine_z = { 'progress', 'location', },
    },
    extensions = { 'aerial', 'fzf', 'nvim-tree', 'quickfix', 'fugitive', },
    -- options = { theme = 'jellybeans' }
})
