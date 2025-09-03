if not vim.g.plugs['nvim-lspconfig'] then
  return
end

require('lspconfig')
require('mason').setup()
require("mason-lspconfig").setup()


local function hover_twice()
  vim.lsp.buf.hover()
  vim.lsp.buf.hover()
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(args)
  if not (args.data and args.data.client_id) then
    return
  end
  local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
  local bufnr = args.buf
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_set_option_value('omnifunc', 'v:lua.vim.lsp.omnifunc', { buf = bufnr })
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gH', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<F1>', hover_twice, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', 'gS', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader><leader>a', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<F3>', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<leader><leader>p', function() vim.lsp.buf.code_action({ apply = true }) end, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<leader>sf', vim.lsp.buf.format, bufopts)

  vim.keymap.set('n', 'gl', vim.diagnostic.open_float, bufopts)
  vim.keymap.set('n', '<leader>cl', vim.diagnostic.setloclist, bufopts)

  -- buffer symbol highlighting
  if client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
    vim.api.nvim_create_augroup("lsp_document_highlight", {
      clear = false,
    })
    vim.api.nvim_clear_autocmds {
      buffer = bufnr,
      group = "lsp_document_highlight",
    }
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

  -- folding
  if client:supports_method(vim.lsp.protocol.Methods.textDocument_foldingRange) then
    local win = vim.api.nvim_get_current_win()
    vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
  end

  -- formatting
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

  -- if client:supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
  --   vim.opt.completeopt = { 'menu', 'menuone', 'noselect', 'fuzzy', 'popup' }
  --   vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
  --   vim.keymap.set('i', '<C-Space>', vim.lsp.completion.get, bufopts)
  -- end
  --
  -- if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlineCompletion) then
  --   vim.opt.completeopt = { 'menu', 'menuone', 'noselect', 'fuzzy', 'popup' }
  --   vim.lsp.inline_completion.enable(true)
  --   vim.keymap.set('i', '<Tab>',
  --     function()
  --       if not vim.lsp.inline_completion.get() then
  --         return "<Tab>"
  --       end
  --     end,
  --     { expr = true, replace_keycodes = true, buffer = bufnr })
  -- end

  vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
end

local capabilities = {
  offsetEncoding = { 'utf-16' },
  general = {
    positionEncodings = { 'utf-16' },
  },
}
if vim.g.plugs['blink.cmp'] then
  capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities())
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lspconfig", { clear = true }),
  callback = on_attach,
})

vim.lsp.config("*", {
  capabilities = capabilities,
  root_markers = { ".git", "Gemfile" },
})
vim.lsp.config('ruby_lsp', {
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { 'ruby' },
  init_options = {
    enabledFeatures = {
      "codeActions",
      "diagnostics",
      "documentHighlights",
      "documentSymbols",
      "hover",
      "inlayHint",
      "completion",
      "definition",
      "workspaceSymbol",
      "signatureHelp",
      "onTypeFormatting",
      -- "formatting",
      -- "documentLink",
      -- "foldingRanges",
      -- "selectionRanges",
      -- "semanticHighlighting",
      -- "codeLens",
    },
    addonSettings = {
      ["Ruby LSP Rails"] = {
        enablePendingMigrationsPrompt = false
      }
    }
  }
})
vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        special = { reload = "require" },
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.fn.expand "$VIMRUNTIME/lua",
          vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"
        },
        -- Make the server aware of Neovim runtime files
        -- library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
})
vim.lsp.config('gopls', {
  filetypes = { 'go' },
  root_markers = { '.git', 'go.mod' },
  init_options = {
    usePlaceholders = true,
    completeUnimported = true,
    staticcheck = true,
  },
})
vim.lsp.config('copilot', {
  settings = {
    telemetry = {
      enable = false,
    },
  },
})

vim.lsp.enable('ruby_lsp')
vim.lsp.enable('rust_analyzer')
vim.lsp.enable('lua_ls')
vim.lsp.enable('gopls')
vim.lsp.enable('bashls')
-- for now using copilot.vim
-- vim.lsp.enable('copilot')

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
    },
  }
})

vim.diagnostic.config({
  underline = {
    severity = { min = vim.diagnostic.severity.ERROR }
  },
  -- virtual_text = false,
  virtual_text = {
    severity = { min = vim.diagnostic.severity.WARN }
  },
  severity_sort = true,
  jump = {
    float = true
  },
  float = {
    border = 'rounded',
    source = true,
    header = '',
    prefix = '',
  },
})
