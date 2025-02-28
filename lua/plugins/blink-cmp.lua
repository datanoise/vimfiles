if not vim.g.plugs['blink.cmp'] then
  return
end

require('blink.cmp').setup({
  completion = {
    list = {
      selection = { preselect = false }
    }
  },
  keymap = {
    preset = 'default',
    ['<CR>'] = { 'accept', 'fallback' },
    ['<C-j>'] = { 'select_next' },
    ['<C-k>'] = { 'select_prev' },
  },
  appearance = {
      -- Sets the fallback highlight groups to nvim-cmp's highlight groups
      -- Useful for when your theme doesn't support blink.cmp
      -- Will be removed in a future release
      use_nvim_cmp_as_default = true,
      -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono'
  },

  -- Default list of enabled providers defined so that you can extend it
  -- elsewhere in your config, without redefining it, due to `opts_extend`
  sources = {
    default = { 'snippets', 'buffer', 'lsp', 'path' },
    providers = {
      buffer = {
        opts = {
          get_bufnrs = function()
            return vim.tbl_filter(function(bufnr)
              return vim.bo[bufnr].buftype == ''
            end, vim.api.nvim_list_bufs())
          end
        }
      },
      lsp = {
        fallbacks = {},
      }
    },
  },
  fuzzy = { implementation = "prefer_rust_with_warning" },
  -- signature = { enabled = true }
  cmdline = {
    keymap = {
      preset = 'cmdline',
      -- recommended, as the default keymap will only show and select the next item
      ['<Tab>'] = { 'show', 'accept' },
      ['<C-j>'] = { 'select_next' },
      ['<C-k>'] = { 'select_prev' },
    },
    completion = {
      menu = {
        auto_show = function()
          return vim.fn.getcmdtype() == ':'
          -- enable for inputs as well, with:
          -- or vim.fn.getcmdtype() == '@'
        end,
      },
    }
  }
})
