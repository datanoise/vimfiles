if not vim.g.plugs['neotest'] then
    return
end

require("neotest").setup({
  quickfix = {
    enabled = true,
  },
  adapters = {
    require("neotest-vim-test")({
      ignore_file_types = { "python", "vim", "lua" },
    }),
    require("neotest-minitest"),
    require("neotest-rspec"),
  },
})

vim.keymap.set("n", "<leader>tk", function()
  require("neotest").run.run()
end, { noremap = true, silent = true, desc = "Run nearest test" })

vim.keymap.set("n", "<leader>tg", function()
  require("neotest").run.run(vim.fn.expand("%"))
end, { noremap = true, silent = true, desc = "Run test for the current file" })

vim.keymap.set("n", "<leader>ta", function()
  require("neotest").run.run({ suite = true })
end, { noremap = true, silent = true, desc = "Run test suite" })

vim.keymap.set("n", "<leader>to", function()
  require("neotest").output.open({ enter = true })
end, { noremap = true, silent = true, desc = "Show test output" })

vim.keymap.set("n", "<leader>tp", function()
  require("neotest").output_panel.open()
end, { noremap = true, silent = true, desc = "Show test output" })

vim.keymap.set("n", "<leader>tm", function()
  require("neotest").summary.open()
end, { noremap = true, silent = true, desc = "Show test summary" })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "neotest-summary",
  callback = function()
    vim.keymap.set("n", "q", function()
      require("neotest").summary.close()
    end, { buffer = true, desc = "Close test summary" })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "neotest-output",
  callback = function()
    vim.keymap.set("n", "q", function()
      vim.cmd("q")
    end, { buffer = true, desc = "Close test output" })
  end,
})
