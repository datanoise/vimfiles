if not vim.g.plugs['mini.nvim'] then
    return
end

require('mini.indentscope').setup({
    draw = {animation = require("mini.indentscope").gen_animation.none() },
    symbol = ''
})
require('mini.files').setup({
    mappings = {
        go_in = '<CR>',
    },
})
require('mini.pick').setup()
require('mini.extra').setup()
require('mini.splitjoin').setup({
    mappings = {
        toggle = 'gT',
        split = '',
        join = '',
    },
})
-- require('mini.diff').setup()
local miniclue = require('mini.clue')
miniclue.setup({
 triggers = {
    -- Leader triggers
    { mode = 'n', keys = '<Leader>' },
    { mode = 'x', keys = '<Leader>' },

    -- Built-in completion
    { mode = 'i', keys = '<C-x>' },

    -- `g` key
    { mode = 'n', keys = 'g' },
    { mode = 'x', keys = 'g' },

    -- Marks
    { mode = 'n', keys = "'" },
    { mode = 'n', keys = '`' },
    { mode = 'x', keys = "'" },
    { mode = 'x', keys = '`' },

    -- Registers
    { mode = 'n', keys = '"' },
    { mode = 'x', keys = '"' },
    { mode = 'i', keys = '<C-r>' },
    { mode = 'c', keys = '<C-r>' },

    -- Window commands
    { mode = 'n', keys = '<C-w>' },

    -- `z` key
    { mode = 'n', keys = 'z' },
    { mode = 'x', keys = 'z' },
  },

  clues = {
    -- Enhance this by adding descriptions for <Leader> mapping groups
    miniclue.gen_clues.builtin_completion(),
    miniclue.gen_clues.g(),
    miniclue.gen_clues.marks(),
    miniclue.gen_clues.registers(),
    miniclue.gen_clues.windows(),
    miniclue.gen_clues.z(),
  },
})
require('mini.bufremove').setup()

vim.keymap.set("n", "<leader>fd", MiniFiles.open, { desc = "Open file browser" })
vim.keymap.set("n", "<leader>q", MiniBufremove.delete, { desc = "Delete Buffer" })
vim.keymap.set("n", "<leader>ss", function() MiniExtra.pickers.lsp({ scope = 'document_symbol'}) end, { desc = "Document Symbols" })
