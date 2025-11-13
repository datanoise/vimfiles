if not vim.g.plugs['nvim-cmp'] then
  return
end

vim.cmd [[set completeopt=menu,menuone,noselect]]

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp_buffer_list = function()
  local bufs = {}
  for _, v in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(v) then
      bufs[#bufs + 1] = v
    end
  end
  return bufs
end

local cmp = require('cmp')
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local luasnip = require("luasnip")
local lspkind = require('lspkind')

local tab_handler = function(fallback)
  local copilot_suggestion = vim.fn['copilot#GetDisplayedSuggestion']
  local has_copilit_suggestion = copilot_suggestion ~= nil and copilot_suggestion().text ~= ''
  if has_copilit_suggestion then
    fallback()
  elseif cmp.visible() then
    cmp.select_next_item()
  elseif luasnip.expand_or_locally_jumpable() then
    luasnip.expand_or_jump()
  elseif has_words_before() then
    cmp.complete()
  else
    fallback()
  end
end

cmp.setup({
  preselect = cmp.PreselectMode.None,
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  matching = {
    disallow_prefix_unmatching = true,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
    ["<Tab>"] = cmp.mapping(tab_handler, { "i", "s" }),
    ["<C-n>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<C-p>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = 'luasnip', option = { use_show_condition = false } },
    { name = 'nvim_lsp' },
    {
      name = 'buffer',
      option = {
        keyword_length = 4,
        get_bufnrs = function()
          -- return vim.api.nvim_list_bufs()
          return cmp_buffer_list()
        end
      }
    },
    { name = 'path' },
  }),
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.disable,
  },
  formatting = {
    format = lspkind.cmp_format({
      mode = 'text',
      use_text = false,
      maxwidth = {
        menu = 50,
        abbr = 50,
      }
    })
  },
})

cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)
