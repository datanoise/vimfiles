if not vim.g.plugs['nvim-treesitter'] then
  return
end

vim.cmd [[
" set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
]]


require('nvim-ts-autotag').setup({
  filetypes = { "html" , "xml", "eruby" },
})

require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "lua", "rust", "ruby", "python", "javascript",
    "typescript", "vim", "xml", "embedded_template", "html" },
  highlight = {
    enable = true,
    disable = {"ruby", "embedded_template", "vim"}
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
    disable = {"ruby", "rust"}
  },
  -- autotag = {
  --   enable = true,
  -- },
  endwise = {
    enable = true,
  },
  matchup = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        -- you can optionally set descriptions to the mappings (used in the desc parameter of nvim_buf_set_keymap
        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
        -- You can also use captures from other query groups like `locals.scm`
        ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
      },
      -- You can choose the select mode (default is charwise 'v')
      selection_modes = {
        ['@parameter.outer'] = 'v', -- charwise
        ['@function.outer'] = 'V', -- linewise
        ['@class.outer'] = '<c-v>', -- blockwise
      },
      -- If you set this to `true` (default is `false`) then any textobject is
      -- extended to include preceding xor succeeding whitespace. Succeeding
      -- whitespace has priority in order to act similarly to eg the built-in
      -- `ap`.
      include_surrounding_whitespace = false,
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>>"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader><"] = "@parameter.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
    lsp_interop = {
      enable = true,
      border = 'none',
      peek_definition_code = {
        ["<leader>df"] = "@function.outer",
        ["<leader>dF"] = "@class.outer",
      },
    },
  },
}
require'treesitter-context'.setup {
  max_lines = 2,
  patterns = {
    ruby = {
      'block'
    }
  }
}

-- local language = require"vim.treesitter.language"
-- language.register("yaml", "eruby.yaml")
