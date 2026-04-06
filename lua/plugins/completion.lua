local function configure_autopairs()
  require("nvim-autopairs").setup({
    ignored_next_char = [=[[%w%%%'%[%"]]=],
  })

  local Rule = require('nvim-autopairs.rule')
  local npairs = require('nvim-autopairs')
  local cond = require('nvim-autopairs.conds')
  npairs.add_rules({
    Rule(' ', ' ')
      :with_pair(function(opts)
        local pair = opts.line:sub(opts.col - 1, opts.col)
        return vim.tbl_contains({ '()', '[]', '{}' }, pair)
      end),
    Rule('( ', ' )')
      :with_pair(function() return false end)
      :with_move(function(opts) return opts.prev_char:match('.%)') ~= nil end)
      :use_key(')'),
    Rule('{ ', ' }')
      :with_pair(function() return false end)
      :with_move(function(opts) return opts.prev_char:match('.%}') ~= nil end)
      :use_key('}'),
    Rule('[ ', ' ]')
      :with_pair(function() return false end)
      :with_move(function(opts) return opts.prev_char:match('.%]') ~= nil end)
      :use_key(']'),
    Rule('<', '>', { 'rust' })
      :with_cr(cond.none())
      :with_pair(cond.not_before_regex('%s', 1))
      :with_move(function(opts) return opts.next_char == '>' and opts.char == '>' end),
  })
end

local function configure_luasnip()
  local luasnip = require("luasnip")
  local types = require("luasnip.util.types")
  luasnip.config.setup({
    delete_check_events = 'TextChanged,InsertEnter',
    region_check_events = 'CursorHold,InsertEnter,InsertLeave',
    ext_opts = {
      [types.choiceNode] = { active = { virt_text = { { "●", "JellyYellow" } } } },
      [types.insertNode] = { active = { virt_text = { { "●", "JellyBlue" } } } },
    },
  })
  require("luasnip.loaders.from_snipmate").lazy_load()
  vim.keymap.set({ 'i', 's' }, '<C-j>', function() require('luasnip').jump(1) end, { silent = true })
  vim.keymap.set('s', '<Tab>', function() require('luasnip').jump(1) end, { silent = true })
  vim.keymap.set('s', '<S-Tab>', function() require('luasnip').jump(-1) end, { silent = true })
end

local function configure_nvim_cmp()
  vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end
  local cmp_buffer_list = function()
    local bufs = {}
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_loaded(bufnr) then
        bufs[#bufs + 1] = bufnr
      end
    end
    return bufs
  end
  local cmp = require('cmp')
  local cmp_autopairs = require('nvim-autopairs.completion.cmp')
  local luasnip = require("luasnip")
  local lspkind = require('lspkind')

  local has_copilot_suggestion = function()
    if vim.fn.exists('*copilot#GetDisplayedSuggestion') == 0 then return false end
    local suggestion = vim.fn['copilot#GetDisplayedSuggestion']()
    return suggestion ~= nil and suggestion.text ~= ''
  end

  local tab_handler = function(fallback)
    if has_copilot_suggestion() then
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
    snippet = { expand = function(args) require('luasnip').lsp_expand(args.body) end },
    matching = { disallow_prefix_unmatching = true },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = false }),
      ['<Tab>'] = cmp.mapping(tab_handler, { "i", "s" }),
      ['<C-n>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.jumpable(1) then
          luasnip.jump(1)
        else
          fallback()
        end
      end, { "i", "s" }),
      ['<C-p>'] = cmp.mapping(function(fallback)
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
      { name = 'buffer', option = { keyword_length = 4, get_bufnrs = cmp_buffer_list } },
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
        maxwidth = { menu = 50, abbr = 50 },
      }),
    },
  })
  cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
end

return {
  { 'windwp/nvim-autopairs', config = configure_autopairs },
  { 'rafamadriz/friendly-snippets' },
  { 'L3MON4D3/LuaSnip', config = configure_luasnip },
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/cmp-path' },
  { 'hrsh7th/cmp-cmdline' },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-nvim-lsp',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp-document-symbol',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'onsails/lspkind.nvim',
      'windwp/nvim-autopairs',
    },
    config = configure_nvim_cmp,
  },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'saadparwaiz1/cmp_luasnip' },
  { 'hrsh7th/cmp-nvim-lsp-document-symbol' },
  { 'hrsh7th/cmp-nvim-lsp-signature-help' },
  { 'onsails/lspkind.nvim' },
}
