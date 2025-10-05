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
        preview = {
            hidden = true,
        }
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

-- ---@diagnostic disable-next-line: duplicate-set-field
-- function _G.fzf_aerial(opts)
--     opts = opts or {}
--     opts.prompt = "Document Symbols"
--     opts.actions = {
--         ['default'] = function(selected)
--             require('aerial.fzf').goto_symbol(selected[1])
--         end
--     }
--     fzf.fzf_exec(require('aerial.fzf').get_labels(), opts)
-- end

-- vim.cmd([[
-- nnoremap <silent> <leader>; :FzfLua builtin<CR>
-- nnoremap <silent> <leader>l :FzfLua buffers<CR>
-- nnoremap <silent> <leader>m :FzfLua files<CR>
-- nnoremap <silent> <leader>F :FzfLua files cwd=%:h<CR>
-- nnoremap <silent> <leader>e :FzfLua oldfiles<CR>
-- ]])
