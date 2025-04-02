if not vim.g.plugs['nvim-lspconfig'] then
  return
end

local lspconfig = require('lspconfig')

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
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
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
  vim.keymap.set('n', '<leader><leader>p', function() vim.lsp.buf.code_action({apply = true}) end, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<leader>sf', vim.lsp.buf.format, bufopts)

  vim.keymap.set('n', 'gl', vim.diagnostic.open_float, bufopts)
  vim.keymap.set('n', '<leader>cl', vim.diagnostic.setloclist, bufopts)

  -- buffer symbol highlighting
  if client:supports_method "textDocument/documentHighlight" then
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

  if client:supports_method('textDocument/foldingRange') then
    local win = vim.api.nvim_get_current_win()
    vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
  end

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

vim.lsp.config("*", {
  capabilities = capabilities,
  root_markers = { ".git", "Gemfile" },
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lspconfig", { clear = true }),
  callback = on_attach,
})

require('mason').setup()
require("mason-lspconfig").setup()

lspconfig.ruby_lsp.setup{
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { 'ruby' },
  init_options = {
    enabledFeatures = {
      "codeActions",
      "diagnostics",
      "documentHighlights",
      -- "documentLink",
      "documentSymbols",
      "foldingRanges",
      "formatting",
      "hover",
      "inlayHint",
      -- "onTypeFormatting",
      "selectionRanges",
      -- "semanticHighlighting",
      "completion",
      -- "codeLens",
      "definition",
      "workspaceSymbol",
      "signatureHelp",
    },
    addonSettings = {
      ["Ruby LSP Rails"] = {
        enablePendingMigrationsPrompt = false
      }
    }
  }
}

-- lspconfig.coffeesense.setup {
--   filetypes = { "coffee" },
-- }

lspconfig.rust_analyzer.setup{}

lspconfig['lua_ls'].setup{
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        special = { reload = "require" },
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
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
}

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

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.rs",
  callback = function ()
    vim.lsp.buf.format()
  end
})
