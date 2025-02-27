if not vim.g.plugs['neotest'] then
    return
end

require("neotest").setup({
  quickfix = {
    enabled = true,
  },
  adapters = {
    require("neotest-minitest")
  },
})
