 require('lualine').setup({
     sections = {
         lualine_c = { { 'filename', path = 1 }, },
         lualine_x = { {'aerial', sep = " ⟩ " }, 'filetype', },
     },
     extensions = { 'aerial', 'fzf', 'nvim-tree', 'quickfix', 'fugitive', }
 })
