if not vim.g.plugs['blink.cmp'] then
  return
end

local blink = require('blink.cmp')
blink.setup({
  completion = {
    list = {
      selection = { preselect = false }
    }
  },
  keymap = {
    preset = 'default',
    ['<Tab>'] = {
      function(cmp)
        local copilot_suggestion = vim.fn['copilot#GetDisplayedSuggestion']
        if cmp.is_menu_visible() and (copilot_suggestion == nil or copilot_suggestion().text == '') then
          return cmp.select_next()
        end
      end,
      'snippet_forward',
      'fallback'
    },
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
        min_keyword_length = 5,
        opts = {
          get_bufnrs = function()
            return vim.tbl_filter(function(bufnr)
              return vim.bo[bufnr].buftype == ''
            end, vim.api.nvim_list_bufs())
          end
        }
      },
      lsp = {
        min_keyword_length = 5,
        fallbacks = {},
      },
      cmdline = {
        min_keyword_length = 0,
      },
    },
  },
  fuzzy = { implementation = "prefer_rust_with_warning" },
  -- signature = { enabled = true }
  cmdline = {
    enabled = false,
    keymap = {
      preset = 'cmdline',
      ['<Tab>'] = { 'select_next' },
      ['<C-j>'] = { 'select_next' },
      ['<C-k>'] = { 'select_prev' },
      ['<CR>'] = { 'accept', 'fallback' },
    },
    sources = function()
      local type = vim.fn.getcmdtype()
      -- Search forward and backward
      if type == '/' or type == '?' then return { 'buffer' } end
      -- Commands
      if type == ':' or type == '@' then return { 'cmdline' } end
      return {}
    end,
    completion = {
      list = {
        selection = {
          -- When `true`, will automatically select the first item in the completion list
          preselect = true,
          -- When `true`, inserts the completion item automatically when selecting it
          auto_insert = true,
        },
      },
      -- Whether to automatically show the window when new completion items are available
      menu = {
        auto_show = true,
        -- auto_show = function()
        --   return vim.fn.getcmdtype() == ':'
        --   -- enable for inputs as well, with:
        --   -- or vim.fn.getcmdtype() == '@'
        -- end,
      },
      -- Displays a preview of the selected item on the current line
      ghost_text = { enabled = true }
    }
  }
})
