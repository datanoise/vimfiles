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
  { 'nvim-lualine/lualine.nvim',
    dependencies = { 'stevearc/aerial.nvim', 'kyazdani42/nvim-web-devicons' },
    opts = {
      sections = {
        lualine_c = { { 'filename', path = 1 } },
        lualine_x = { { 'aerial', sep = " ", colored = true } },
        lualine_y = { 'filetype' },
        lualine_z = { 'progress', 'location' },
      },
      extensions = { 'aerial', 'fzf', 'nvim-tree', 'quickfix', 'fugitive' },
    },
  },
  { 'gbprod/yanky.nvim', config = configure_yanky },
  { 'rcarriga/nvim-notify', name = 'nvim-notify', event = 'VeryLazy', opts = {} },
  { 'kylechui/nvim-surround', opts = {} },
  { 'kyazdani42/nvim-web-devicons' },
  { 'j-hui/fidget.nvim', event = 'LspAttach', opts = {
    notification = {
      window = { winblend = 0 },
    },
  } },
  { 'kdheepak/lazygit.nvim', cmd = 'LazyGit' },
  { 'folke/trouble.nvim',
    cmd = { 'Trouble', 'TroubleToggle' },
    keys = { { '<leader>gt', '<Cmd>TroubleToggle<CR>', silent = true } },
    opts = {
      signs = {
        error = " ",
        warning = " ",
        hint = "",
        information = " ",
        other = " ",
      },
    },
  },
}
