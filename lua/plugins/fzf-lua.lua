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
            default = 'bat',
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
