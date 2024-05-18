if not vim.g.plugs['mini.nvim'] then
    return
end

require('mini.indentscope').setup({
    draw = {animation = require("mini.indentscope").gen_animation.none() },
    symbol = ''
})
require('mini.files').setup()
require('mini.pick').setup()
require('mini.extra').setup()

vim.keymap.set("n", "<leader>fd", MiniFiles.open, { desc = "Open file browser" })
