if not vim.g.plugs['hop.nvim'] then
    return
end

require'hop'.setup()

vim.cmd [[
nnoremap <silent> <leader>fg :HopWord<CR>
]]
