if not vim.g.plugs['telescope.nvim'] then
  return
end

vim.cmd [[
nnoremap <silent> <leader>T :Telescope<CR>
nnoremap <silent> <leader>; :Telescope<CR>
nnoremap <silent> <leader>l :Telescope buffers<CR>
nnoremap <silent> <leader>m :Telescope find_files<CR>
nnoremap <silent> <leader>F :Telescope find_files search_dirs=%:h<CR>
nnoremap <silent> <leader>e :Telescope oldfiles<CR>
nnoremap <silent> <leader>n :Telescope aerial theme=dropdown<CR>
]]

local actions = require("telescope.actions")
local action_layout = require("telescope.actions.layout")
require('telescope').load_extension('aerial')
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ["<M-p>"] = action_layout.toggle_preview,
        ["<Esc>"] = actions.close
      }
    },
    preview = {
      hide_on_startup = true
    },
  },
  pickers = {
    find_files = {
      theme = "dropdown"
    },
    buffers = {
      theme = "dropdown",
      sort_lastused = true,
      ignore_current_buffer = true,
    },
    oldfiles = {
      theme = "dropdown"
    },
    aerial = {
      theme = "dropdown"
    },
  },
  extensions = {
    aerial = {
      -- Display symbols as <root>.<parent>.<symbol>
      show_nesting = true
    }
  },
}
