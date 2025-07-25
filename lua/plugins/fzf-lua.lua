if not vim.g.plugs['fzf-lua'] then
    return
end

local fzf = require 'fzf-lua'
fzf.register_ui_select()

fzf.setup {
    'fzf-native',
    winopts = {
        width = 0.8,
        height = 0.6,
    },
    btags = {
        ctags_gen = true
    },
    lsp = {
        code_actions = {
            previewer = "codeaction"
        }
    },
    resume = true,
}

---@diagnostic disable-next-line: duplicate-set-field
function _G.fzf_aerial(opts)
    opts = opts or {}
    opts.prompt = "Document Symbols"
    opts.actions = {
        ['default'] = function(selected)
            require('aerial.fzf').goto_symbol(selected[1])
        end
    }
    fzf.fzf_exec(require('aerial.fzf').get_labels(), opts)
end

---@diagnostic disable-next-line: duplicate-set-field
function _G.fzf_symbols()
    local lsp_symbols = false
    local local_clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
    for _, client in ipairs(local_clients) do
        if client.server_capabilities.documentSymbolProvider then
            lsp_symbols = true
            break
        end
    end
    if lsp_symbols then
        require('fzf-lua').lsp_document_symbols()
    else
        require('fzf-lua').btags()
    end
end

vim.cmd([[
nnoremap <silent> <leader>; :FzfLua builtin<CR>
nnoremap <silent> <leader>l :FzfLua buffers previewer=false<CR>
nnoremap <silent> <leader>m :FzfLua files previewer=false<CR>
nnoremap <silent> <leader>F :FzfLua files cwd=%:h<CR>
nnoremap <silent> <leader>e :FzfLua oldfiles previewer=false<CR>
nnoremap <silent> <leader>n :lua fzf_symbols()<CR>
]])
