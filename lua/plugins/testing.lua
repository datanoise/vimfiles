local function configure_neotest()
  require("neotest").setup({
    quickfix = { enabled = true },
    adapters = {
      require("neotest-vim-test")({ ignore_file_types = { "python", "vim", "lua" } }),
      require("neotest-minitest"),
      require("neotest-rspec"),
    },
  })

  vim.api.nvim_create_autocmd("FileType", {
    pattern = "neotest-summary",
    callback = function()
      vim.keymap.set("n", "q", function() require("neotest").summary.close() end, { buffer = true, desc = "Close test summary" })
    end,
  })
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "neotest-output",
    callback = function()
      vim.keymap.set("n", "q", function() vim.cmd("q") end, { buffer = true, desc = "Close test output" })
    end,
  })
end

return {
  { 'nvim-neotest/nvim-nio' },
  { 'nvim-neotest/neotest', dependencies = {
    'nvim-neotest/nvim-nio', 'zidhuss/neotest-minitest', 'nvim-neotest/neotest-vim-test', 'olimorris/neotest-rspec',
  },
    keys = {
      { '<leader>tN', function() require("neotest").run.run() end, desc = "Run nearest test" },
      { '<leader>tF', function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run test for the current file" },
      { '<leader>tS', function() require("neotest").run.run({ suite = true }) end, desc = "Run test suite" },
      { '<leader>to', function() require("neotest").output.open({ enter = true }) end, desc = "Show test output" },
      { '<leader>tp', function() require("neotest").output_panel.toggle() end, desc = "Toggle test output panel" },
      { '<leader>tc', function() require("neotest").output_panel.clear() end, desc = "Clear test output panel" },
      { '<leader>ty', function() require("neotest").summary.toggle() end, desc = "Toggle test summary" },
    },
    config = configure_neotest,
  },
  { 'zidhuss/neotest-minitest' },
  { 'nvim-neotest/neotest-vim-test' },
  { 'olimorris/neotest-rspec' },
}
