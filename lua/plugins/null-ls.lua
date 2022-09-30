if not vim.g.plugs['null-ls.nvim'] then
  return
end

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
    check_exit_code = function(code)
      return code <= 1
    end,
    on_output = function(params)
      local output = params.output.stdin
      if output then
        local parser = helpers.diagnostics.from_json({
          severities = {
            warn = helpers.diagnostics.severities.warning,
            error = helpers.diagnostics.severities.error,
          },
        })
        local offenses = {}

        for _, offense in ipairs(output) do
          table.insert(offenses, {
            message = offense.message,
            line = offense.lineNumber,
            level = offense.level,
          })
        end

        return parser({
          output = offenses,
        })
      end
    end
  }),
}

null_ls.register(coffeelint)

null_ls.setup({
  sources = {
    coffeelint,
    null_ls.builtins.diagnostics.jsonlint,
    -- null_ls.builtins.diagnostics.luacheck,
    -- null_ls.builtins.diagnostics.rubocop,
  },
})

