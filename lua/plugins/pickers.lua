local force_fzf = false

local mini_enabled = false
local fzf_enabled = false
local use_mini = false

if vim.g.plugs['mini.nvim'] then
    mini_enabled = true
end

if vim.g.plugs['fzf-lua'] then
    fzf_enabled = true
end

if mini_enabled and not force_fzf then
    use_mini = true
elseif fzf_enabled then
    use_mini = false
else
    print("Please install fzf-lua or mini.nvim for symbol picking")
    return
end

local function pick_symbols()
    local lsp_symbols = false
    local local_clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
    for _, client in ipairs(local_clients) do
        if client.server_capabilities.documentSymbolProvider then
            lsp_symbols = true
            break
        end
    end
    if lsp_symbols then
        if use_mini then
            MiniExtra.pickers.lsp({ scope = 'document_symbol' })
        else
            require('fzf-lua').lsp_document_symbols()
        end
    else
        if fzf_enabled then
            require('fzf-lua').btags()
        else
            print("No LSP symbols available. Please install fzf-lua for tag picking")
        end
    end
end

local function fzf_aerial(opts)
    opts = opts or {}
    opts.prompt = "Document Symbols"
    opts.actions = {
        ['default'] = function(selected)
            require('aerial.fzf').goto_symbol(selected[1])
        end
    }
    require('fzf-lua').fzf_exec(require('aerial.fzf').get_labels(), opts)
end

if fzf_enabled then
    vim.keymap.set("n", "<M-N>", fzf_aerial, { desc = "Document Symbols" })
end

vim.keymap.set("n", "<M-.>", pick_symbols, { desc = "Pick symbols" })

if use_mini then
    vim.keymap.set("n", "<M-n>", function() MiniExtra.pickers.lsp({ scope = 'document_symbol' }) end,
        { desc = "Document Symbols" })
    vim.keymap.set("n", "<M-,>", MiniPick.registry.buffers_mru, { desc = "Pick buffers" })
    vim.keymap.set("n", "<M-m>", MiniPick.builtin.files, { desc = "Pick files" })
    vim.keymap.set("n", "<M-o>", MiniExtra.pickers.oldfiles, { desc = "Pick old files" })
    vim.keymap.set("n", "<M-F>",
        function() require('mini.pick').builtin.files({}, { source = { cwd = vim.fn.expand('%:p:h') } }) end,
        { desc = "Pick local files" })
else
    vim.cmd([[
        nnoremap <silent> <M-;> :FzfLua builtin<CR>
        nnoremap <silent> <M-,> :FzfLua buffers<CR>
        nnoremap <silent> <M-m> :FzfLua files<CR>
        nnoremap <silent> <M-F> :FzfLua files cwd=%:h<CR>
        nnoremap <silent> <M-o> :FzfLua oldfiles<CR>
    ]])
end

local function switch_prev_buf()
    local prev = vim.fn.bufname('#')
    if prev ~= '__InputList__' and vim.fn.bufloaded(prev) ~= 0 then
        vim.cmd('buffer #')
    else
        if use_mini then
            MiniPick.registry.buffers_mru()
        else
            require('fzf-lua').buffers()
        end
    end
end

vim.keymap.set('n', '<C-tab>', switch_prev_buf, { silent = true })
vim.keymap.set('n', '<C-^>', switch_prev_buf, { silent = true })
vim.keymap.set('n', '<C-6>', switch_prev_buf, { silent = true })
