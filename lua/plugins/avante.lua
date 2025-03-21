if not vim.g.plugs['avante.nvim'] then
    return
end

require("avante").setup({
  -- The default adapter to use for all strategies
  -- provider = "ollama",
  -- provider = "claude",
  provider = "copilot",
  -- claude = {
  --   api_key_name = "cmd:op read op://personal/Anthropic/credential --no-newline",
  -- },
  vendors = {
    ollama = {
      __inherited_from = "openai",
      api_key_name = "",
      endpoint = "http://127.0.0.1:11434/v1",
      model = "llama3.2:latest",
    },
  },
})

