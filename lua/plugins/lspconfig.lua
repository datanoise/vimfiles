if not vim.g.plugs['nvim-lspconfig'] then
  return
end

local lspconfig = require('lspconfig')

local opts = { noremap=true, silent=true }
vim.keymap.set('n', 'gl', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>cl', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gH', vim.lsp.buf.hover, bufopts)
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
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<leader>sf', vim.lsp.buf.format, bufopts)
end

require('mason').setup()
require("mason-lspconfig").setup()
require("mason-lspconfig").setup_handlers({
  function (server_name)
    lspconfig[server_name].setup({
      on_attach = on_attach,
    })
  end,
  ["rust_analyzer"] = function ()
    local function read_ra_settings()
      local file = io.open(".rust-analyzer.json", "rb")
      if not file then
        return {}
      end
      local content = file:read("*a")
      file:close()
      return vim.json.decode(content) or {}
    end
    local local_config = read_ra_settings()

    require("rust-tools").setup({
      server = {
        on_attach = on_attach,
        settings = {
          -- cmd = "~/.cargo/bin/rust-analyzer",
          ["rust-analyzer"] = local_config,
        }
      },
      tools = {
        inlay_hints = {
          highlight = "NonText",
          only_current_line = true,
        }
      }
    })

    -- lspconfig["rust_analyzer"].setup({
    --   on_attach = on_attach,
    --   settings = {
    --    ["rust-analyzer"] = local_config,
    --   }
    -- })
  end,
  ["sumneko_lua"] = function ()
    lspconfig['sumneko_lua'].setup{
      on_attach = on_attach,
      settings = {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT',
          },
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = {'vim'},
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = vim.api.nvim_get_runtime_file("", true),
          },
          -- Do not send telemetry data containing a randomized but unique identifier
          telemetry = {
            enable = false,
          },
        },
      },
    }
  end
})

require('lspconfig.ui.windows').default_options.border = 'single'
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
  underline = {
    severity = { min = vim.diagnostic.severity.ERROR }
  },
  virtual_text = false,
  -- virtual_text = {
  --   severity = { min = vim.diagnostic.severity.WARN }
  -- },
  severity_sort = true,
  float = {
    border = 'rounded',
    source = 'always',
    header = '',
    prefix = '',
  },
})

-- vim.o.updatetime = 300
-- vim.cmd [[autocmd! CursorHold * lua vim.diagnostic.open_float(nil, {focus=false})]]

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
  vim.lsp.handlers.hover,
  {border = 'rounded'}
)

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  {border = 'rounded'}
)
