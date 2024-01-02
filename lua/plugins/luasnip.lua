if not vim.g.plugs['LuaSnip'] then
    return
end

local luasnip = require("luasnip")
local types = require("luasnip.util.types")

luasnip.config.setup({
    delete_check_events = 'TextChanged,InsertEnter',
    region_check_events = 'CursorHold,InsertEnter,InsertLeave',
    ext_opts = {
        [types.choiceNode] = {
            active = {
                virt_text = {{"●", "JellyYellow"}}
            }
        },
        [types.insertNode] = {
            active = {
                virt_text = {{"●", "JellyBlue"}}
            }
        }
    },
})

require("luasnip.loaders.from_snipmate").lazy_load()

vim.cmd [[
inoremap <silent> <C-j> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <C-j> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>
]]
