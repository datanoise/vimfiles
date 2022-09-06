" LuaSnip settings
if !has_key(g:plugs, 'LuaSnip')
  finish
endif

lua require("luasnip.loaders.from_snipmate").lazy_load()
inoremap <silent> <C-j> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>
