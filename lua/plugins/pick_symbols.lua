---@diagnostic disable-next-line: duplicate-set-field
function _G.pick_symbols()
    local lsp_symbols = false
    local local_clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
    for _, client in ipairs(local_clients) do
        if client.server_capabilities.documentSymbolProvider then
            lsp_symbols = true
            break
        end
    end
    if lsp_symbols then
        if vim.g.plugs['mini.nvim'] then
            MiniExtra.pickers.lsp({ scope = 'document_symbol' })
        elseif vim.g.plugs['fzf-lua'] then
            require('fzf-lua').lsp_document_symbols()
        else
            print("Please install fzf-lua or mini.nvim for symbol picking")
        end
    else
        if vim.g.plugs['fzf-lua'] then
            require('fzf-lua').btags()
        else
            print("No LSP symbols available. Please install fzf-lua for tag picking")
        end
    end
end

vim.cmd([[
nnoremap <silent> <M-.> :lua pick_symbols()<CR>
]])
