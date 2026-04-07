local function configure_gitsigns()
  require('gitsigns').setup({
    on_attach = function(bufnr)
      local gitsigns = require('gitsigns')
      local function map(mode, lhs, rhs, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, lhs, rhs, opts)
      end
      map('n', ']c', function()
        if vim.wo.diff then
          vim.cmd.normal({ ']c', bang = true })
        else
          gitsigns.nav_hunk('next')
        end
      end)
      map('n', '[c', function()
        if vim.wo.diff then
          vim.cmd.normal({ '[c', bang = true })
        else
          gitsigns.nav_hunk('prev')
        end
      end)
      map('n', '<leader>hs', gitsigns.stage_hunk)
      map('n', '<leader>hr', gitsigns.reset_hunk)
      map('v', '<leader>hs', function() gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end)
      map('v', '<leader>hr', function() gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end)
      map('n', '<leader>hS', gitsigns.stage_buffer)
      map('n', '<leader>hR', gitsigns.reset_buffer)
      map('n', '<leader>hp', gitsigns.preview_hunk)
      map('n', '<leader>gb', function() gitsigns.blame_line({ full = true }) end)
      map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
      map('n', '<leader>hd', gitsigns.diffthis)
      map('n', '<leader>hD', function() gitsigns.diffthis('~') end)
      map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    end,
  })
end

local function configure_lspconfig()
  require('lspconfig')
  local function hover_twice()
    vim.lsp.buf.hover()
    vim.lsp.buf.hover()
  end
  local on_attach = function(args)
    if not (args.data and args.data.client_id) then return end
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    local bufnr = args.buf
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.api.nvim_set_option_value('omnifunc', 'v:lua.vim.lsp.omnifunc', { buf = bufnr })
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'gH', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', '<F1>', hover_twice, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', 'gS', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, bufopts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader><leader>a', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '<F3>', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '<leader><leader>p', function() vim.lsp.buf.code_action({ apply = true }) end, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<leader>sf', vim.lsp.buf.format, bufopts)
    vim.keymap.set('n', 'gl', vim.diagnostic.open_float, bufopts)
    vim.keymap.set('n', '<leader>cl', vim.diagnostic.setloclist, bufopts)
    if client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
      vim.api.nvim_create_augroup("lsp_document_highlight", { clear = false })
      vim.api.nvim_clear_autocmds({ buffer = bufnr, group = "lsp_document_highlight" })
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        group = "lsp_document_highlight",
        buffer = bufnr,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        group = "lsp_document_highlight",
        buffer = bufnr,
        callback = vim.lsp.buf.clear_references,
      })
    end
    if client:supports_method(vim.lsp.protocol.Methods.textDocument_foldingRange) then
      local win = vim.api.nvim_get_current_win()
      vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
    end
    if not client:supports_method(vim.lsp.protocol.Methods.textDocument_willSaveWaitUntil)
        and client:supports_method(vim.lsp.protocol.Methods.textDocument_formatting) then
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = vim.api.nvim_create_augroup('lsp_document_formatting', { clear = false }),
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr, id = client.id, timeout_ms = 1000 })
        end,
      })
    end
    if client:supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
      vim.opt.completeopt = { 'menu', 'menuone', 'noselect', 'fuzzy', 'popup' }
      vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = false })
      vim.keymap.set('i', '<C-Space>', vim.lsp.completion.get, bufopts)
    end
    if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
      vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
    end
  end
  local capabilities = { offsetEncoding = { 'utf-16' }, general = { positionEncodings = { 'utf-16' } } }
  local has_cmp_lsp, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
  if has_cmp_lsp then
    capabilities = vim.tbl_deep_extend('force', capabilities, cmp_nvim_lsp.default_capabilities())
  end
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lspconfig", { clear = true }),
    callback = on_attach,
  })
  vim.lsp.config("*", { capabilities = capabilities, root_markers = { ".git", "Gemfile" } })
  vim.lsp.config('ruby_lsp', {
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = { 'ruby' },
    init_options = {
      enabledFeatures = {
        "codeActions", "diagnostics", "documentHighlights", "documentSymbols", "hover",
        "inlayHint", "completion", "definition", "workspaceSymbol", "signatureHelp", "onTypeFormatting",
      },
      addonSettings = {
        ["Ruby LSP Rails"] = { enablePendingMigrationsPrompt = false },
      },
    },
  })
  vim.lsp.config('lua_ls', {
    settings = {
      Lua = {
        runtime = { version = 'LuaJIT', special = { reload = "require" } },
        diagnostics = { globals = { 'vim' } },
        workspace = {
          checkThirdParty = false,
          library = { vim.fn.expand("$VIMRUNTIME/lua"), vim.fn.expand("$VIMRUNTIME/lua/vim/lsp") },
        },
        telemetry = { enable = false },
      },
    },
  })
  vim.lsp.config('gopls', {
    filetypes = { 'go' },
    root_markers = { '.git', 'go.mod' },
    init_options = { usePlaceholders = true, completeUnimported = true, staticcheck = true },
  })
  vim.lsp.config('copilot', { settings = { telemetry = { enable = false } } })
  for _, server in ipairs({ 'ruby_lsp', 'rust_analyzer', 'lua_ls', 'gopls', 'bashls', 'jdtls', 'kotlin_language_server', 'pylsp', 'vimls' }) do
    vim.lsp.enable(server)
  end
  local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end
  vim.diagnostic.config({
    virtual_lines = false,
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = "󰅚 ",
        [vim.diagnostic.severity.WARN] = "󰀪 ",
        [vim.diagnostic.severity.HINT] = "󰌶 ",
        [vim.diagnostic.severity.INFO] = " ",
      }
    },
    underline = { severity = { min = vim.diagnostic.severity.ERROR } },
    virtual_text = { severity = { min = vim.diagnostic.severity.WARN } },
    severity_sort = true,
    jump = { on_jump = function() vim.diagnostic.open_float() end },
    float = { border = 'rounded', source = true, header = '', prefix = '' },
  })
  local has_tiny_inline, tiny_inline = pcall(require, 'tiny-inline-diagnostic')
  if has_tiny_inline then
    tiny_inline.setup()
    vim.diagnostic.config({ virtual_text = false })
  end
end

local function configure_null_ls()
  local null_ls = require("null-ls")
  local helpers = require("null-ls.helpers")
  local coffeelint = {
    method = null_ls.methods.DIAGNOSTICS,
    filetypes = { "coffee" },
    generator = null_ls.generator({
      command = "coffeelint",
      args = { "--reporter", "raw", "--stdin" },
      to_stdin = true,
      format = "json",
      check_exit_code = function(code) return code <= 1 end,
      on_output = function(params)
        local output = params.output.stdin
        if not output then return end
        local parser = helpers.diagnostics.from_json({
          severities = { warn = helpers.diagnostics.severities.warning, error = helpers.diagnostics.severities.error },
        })
        local offenses = {}
        for _, offense in ipairs(output) do
          table.insert(offenses, { message = offense.message, line = offense.lineNumber, level = offense.level })
        end
        return parser({ output = offenses })
      end,
    }),
  }
  null_ls.register(coffeelint)
  null_ls.setup({ sources = { coffeelint } })
end

local function configure_treesitter()
  local treesitter = require('nvim-treesitter')
  local install_dir = vim.fn.expand('~/.vim/lazy/treesitter')
  local managed_parsers = {
    'bash', 'c', 'embedded_template', 'html', 'javascript', 'lua', 'markdown',
    'markdown_inline', 'python', 'ruby', 'rust', 'sql', 'typescript', 'vim', 'xml',
  }
  pcall(vim.treesitter.language.register, 'embedded_template', 'eruby')
  treesitter.setup({ install_dir = install_dir })
  local missing = vim.tbl_filter(function(lang)
    return not vim.list_contains(treesitter.get_installed(), lang)
  end, managed_parsers)
  if #missing > 0 then
    treesitter.install(missing)
  end
  require('nvim-ts-autotag').setup({ aliases = { eruby = 'html' } })
  local group = vim.api.nvim_create_augroup('datanoise_treesitter', { clear = true })
  vim.api.nvim_create_autocmd('FileType', {
    group = group,
    pattern = { 'c', 'eruby', 'html', 'javascript', 'lua', 'markdown', 'python', 'ruby', 'rust', 'sql', 'typescript', 'vim', 'xml', 'zsh' },
    callback = function(args)
      local filetype = vim.bo[args.buf].filetype
      local lang = ({
        eruby = 'embedded_template',
        javascriptreact = 'javascript',
        sh = 'bash',
        typescriptreact = 'typescript',
        zsh = 'bash',
      })[filetype] or filetype
      pcall(vim.treesitter.start, args.buf, lang)
      vim.wo.foldmethod = 'expr'
      vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      if not vim.tbl_contains({ 'eruby', 'ruby', 'rust', 'vim' }, filetype) then
        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end
    end,
  })
  require('nvim-treesitter-textobjects').setup({
    select = {
      lookahead = true,
      selection_modes = {
        ['@parameter.outer'] = 'v',
        ['@function.outer'] = 'V',
        ['@class.outer'] = '<c-v>',
      },
      include_surrounding_whitespace = false,
    },
    move = { set_jumps = true },
  })
  local select = require('nvim-treesitter-textobjects.select')
  local move = require('nvim-treesitter-textobjects.move')
  local swap = require('nvim-treesitter-textobjects.swap')
  vim.keymap.set({ 'x', 'o' }, 'af', function() select.select_textobject('@function.outer', 'textobjects') end)
  vim.keymap.set({ 'x', 'o' }, 'if', function() select.select_textobject('@function.inner', 'textobjects') end)
  vim.keymap.set({ 'x', 'o' }, 'ac', function() select.select_textobject('@class.outer', 'textobjects') end)
  vim.keymap.set({ 'x', 'o' }, 'ic', function() select.select_textobject('@class.inner', 'textobjects') end)
  vim.keymap.set({ 'x', 'o' }, 'as', function() select.select_textobject('@local.scope', 'locals') end)
  vim.keymap.set('n', '<leader>>', function() swap.swap_next('@parameter.inner') end)
  vim.keymap.set('n', '<leader><', function() swap.swap_previous('@parameter.inner') end)
  vim.keymap.set({ 'n', 'x', 'o' }, ']m', function() move.goto_next_start('@function.outer', 'textobjects') end)
  vim.keymap.set({ 'n', 'x', 'o' }, ']]', function() move.goto_next_start('@class.outer', 'textobjects') end)
  vim.keymap.set({ 'n', 'x', 'o' }, ']M', function() move.goto_next_end('@function.outer', 'textobjects') end)
  vim.keymap.set({ 'n', 'x', 'o' }, '][', function() move.goto_next_end('@class.outer', 'textobjects') end)
  vim.keymap.set({ 'n', 'x', 'o' }, '[m', function() move.goto_previous_start('@function.outer', 'textobjects') end)
  vim.keymap.set({ 'n', 'x', 'o' }, '[[', function() move.goto_previous_start('@class.outer', 'textobjects') end)
  vim.keymap.set({ 'n', 'x', 'o' }, '[M', function() move.goto_previous_end('@function.outer', 'textobjects') end)
  vim.keymap.set({ 'n', 'x', 'o' }, '[]', function() move.goto_previous_end('@class.outer', 'textobjects') end)
  require('treesitter-context').setup({ max_lines = 2, patterns = { ruby = { 'block' } } })
end

return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    build = ':TSUpdate',
    dependencies = {
      'windwp/nvim-ts-autotag', 'nvim-treesitter/nvim-treesitter-context',
      'nvim-treesitter/nvim-treesitter-textobjects', 'RRethy/nvim-treesitter-endwise',
    },
    config = configure_treesitter
  },
  { 'lewis6991/gitsigns.nvim', event = { 'BufReadPre', 'BufNewFile' }, dependencies = { 'nvim-lua/plenary.nvim' }, config = configure_gitsigns },
  { 'mrcjkb/rustaceanvim', ft = 'rust' },
  { 'nvim-lua/plenary.nvim' },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'mason-org/mason.nvim', 'mason-org/mason-lspconfig.nvim', 'hrsh7th/cmp-nvim-lsp',
      'rachartier/tiny-inline-diagnostic.nvim',
    },
    config = configure_lspconfig
  },
  { 'mason-org/mason.nvim',                  opts = {} },
  { 'mason-org/mason-lspconfig.nvim',        opts = {} },
  { 'rachartier/tiny-inline-diagnostic.nvim' },
  { 'dnlhc/glance.nvim', cmd = { 'Glance', 'GlanceDefinitions', 'GlanceReferences', 'GlanceTypeDefinitions', 'GlanceImplementations' } },
  { 'nvimtools/none-ls.nvim',                ft = 'coffee', config = configure_null_ls },
}
