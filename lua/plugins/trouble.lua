if not vim.g.plugs['trouble.nvim'] then
    return
end

local trouble = require'trouble'

trouble.setup({
    signs = {
        error = " ",
        warning = " ",
        hint = "",
        information = " ",
        other = " "
    }
})

vim.cmd([[
nnoremap <silent> <leader>gt :TroubleToggle<CR>
]])
