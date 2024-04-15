if not vim.g.plugs['nvim-lspconfig'] then
  return
end

local lspconfig = require('lspconfig')

local opts = { noremap=true, silent=true }
vim.keymap.set('n', 'gl', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>cl', vim.diagnostic.setloclist, opts)

local function hover_twice()
  vim.lsp.buf.hover()
  vim.lsp.buf.hover()
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
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
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<leader>sf', vim.lsp.buf.format, bufopts)

  -- buffer symbol highlighting
  if client.supports_method "textDocument/documentHighlight" then
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
end

local ruby_timers = {}
local ruby_lsp_on_attach = function(client, bufnr)
  on_attach(client, bufnr)

  -- perform diagnostic resolution
  local callback = function()
    local params = vim.lsp.util.make_text_document_params(bufnr)

    local handler = vim.lsp.handlers["$/progress"]
    local token = 0
    local send_progress = function (kind, title, message, percentage)
      if not handler then
        return
      end

      vim.schedule(function()
        handler(nil, {
          token = token,
          value = {
            kind = kind,
            title = title,
            message = message,
            percentage = percentage,
          },
        }, {
            method = kind,
            client_id = client.id,
          })
      end)
    end

    send_progress("begin", "diagnostics", "Sending request", 0)
    client.request(
      'textDocument/diagnostic',
      { textDocument = params },
      function(err, result)
        if err then return end

        send_progress("end", "diagnostics", "Finished", 100)

        if not result then return end

        vim.lsp.diagnostic.on_publish_diagnostics(
          nil,
          vim.tbl_extend('keep', params, { diagnostics = result.items }),
          {
            method = "end",
            client_id = client.id
          },
          {}
        )
      end
    )
  end
  callback() -- call on attach

  -- vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePre', 'BufReadPost', 'InsertLeave', 'TextChanged' }, {
  --   buffer = bufnr,
  --   callback = callback,
  -- })

  vim.api.nvim_buf_attach(bufnr, false, {
      on_lines = function()
        if ruby_timers[bufnr] then
          vim.fn.timer_stop(ruby_timers[bufnr])
        end
        ruby_timers[bufnr] = vim.fn.timer_start(200, callback)
      end,
      on_detach = function()
        if ruby_timers[bufnr] then
          vim.fn.timer_stop(ruby_timers[bufnr])
        end
      end,
    })
end

-- do not install ruby_ls via Mason because it doesn't install rubocop
require('lspconfig').ruby_lsp.setup{
  on_attach = ruby_lsp_on_attach,
  init_options = {
    enabledFeatures = {
      -- "documentHighlights",
      "documentSymbols",
      "foldingRanges",
      "selectionRanges",
      -- "semanticHighlighting",
      "formatting",
      "codeActions",
    }
  }
}
-- require'lspconfig'.solargraph.setup{}
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
      },
    })
  end,
  ["lua_ls"] = function ()
    lspconfig['lua_ls'].setup{
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
  end,
  ["ruby_lsp"] = function()
    lspconfig['ruby_lsp'].setup{
      on_attach = ruby_lsp_on_attach,
    }
  end,
})

require('lspconfig.ui.windows').default_options.border = 'single'
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.HINT] = "",
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

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.rs",
  callback = function ()
    vim.lsp.buf.format()
  end
})
