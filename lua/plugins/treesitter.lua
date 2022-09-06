require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "lua", "rust", "ruby", "python", "javascript", "typescript", "vim" },
  highlight = {
    enable = true,
    -- disable = {"vim"}
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "<Tab>",
      node_decremental = "<S-Tab>",
      scope_incremental = "<CR>",
    },
  },
  indent = {
    enable = true,
    -- disable = {"ruby"}
  },
  rainbow = {
    enable = true,
    extended_mode = true,
  },
  autotag = {
    enable = true,
  },
  endwise = {
    enable = true,
  },
}
require'treesitter-context'.setup {
  patterns = {
    ruby = {
      'block'
    }
  }
}
require("twilight").setup {}
require('aerial').setup {}

