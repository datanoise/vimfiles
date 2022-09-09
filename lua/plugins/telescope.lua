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
      sort_lastused = true
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
