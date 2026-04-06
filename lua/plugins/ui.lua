local function configure_fidget()
  require("fidget").setup({
    notification = {
      window = { winblend = 0 },
    },
  })
end

local function configure_lualine()
  require('lualine').setup({
    sections = {
      lualine_c = { { 'filename', path = 1 } },
      lualine_x = { { 'aerial', sep = " ", colored = true } },
      lualine_y = { 'filetype' },
      lualine_z = { 'progress', 'location' },
    },
    extensions = { 'aerial', 'fzf', 'nvim-tree', 'quickfix', 'fugitive' },
  })
end

local function configure_notify()
  require("notify").setup()
end

local function configure_trouble()
  require('trouble').setup({
    signs = {
      error = " ",
      warning = " ",
      hint = "",
      information = " ",
      other = " ",
    },
  })
  vim.keymap.set('n', '<leader>gt', '<Cmd>TroubleToggle<CR>', { silent = true })
end

local function configure_yanky()
  require('yanky').setup()
  vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
  vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
  vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
  vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")
  vim.keymap.set("n", "<C-n>", "<Plug>(YankyCycleForward)")
  vim.keymap.set("n", "<C-p>", "<Plug>(YankyCycleBackward)")
end

return {
  { 'nvim-lualine/lualine.nvim', dependencies = { 'stevearc/aerial.nvim', 'kyazdani42/nvim-web-devicons' }, config = configure_lualine },
  { 'gbprod/yanky.nvim', config = configure_yanky },
  { 'rcarriga/nvim-notify', name = 'nvim-notify', config = configure_notify },
  { 'kylechui/nvim-surround' },
  { 'kyazdani42/nvim-web-devicons' },
  { 'j-hui/fidget.nvim', config = configure_fidget },
  { 'kdheepak/lazygit.nvim' },
  { 'folke/trouble.nvim', config = configure_trouble },
}
