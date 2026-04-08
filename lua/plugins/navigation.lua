local function configure_fzf_lua()
  local fzf = require('fzf-lua')
  fzf.register_ui_select()
  fzf.setup({
    'fzf-native',
    winopts = {
      width = 0.8,
      height = 0.6,
      preview = { hidden = true, default = 'bat' },
    },
    btags = { ctags_gen = true },
    lsp = { code_actions = { previewer = "codeaction" } },
    resume = true,
  })
end

local function initialize_fzf_vim()
  vim.g.fzf_preview_window = ''
  vim.g.fzf_action = {
    ['ctrl-t'] = 'tab split',
    ['ctrl-x'] = 'split',
    ['ctrl-s'] = 'split',
    ['ctrl-v'] = 'vsplit',
  }
  vim.g.fzf_layout = { window = { width = 0.9, height = 0.6 } }
  vim.cmd([[cnoreabbrev <expr> fzf ((getcmdtype() ==# ":" && getcmdline() ==# "fzf") ? ("FZF") : ("fzf"))]])
  vim.api.nvim_create_augroup('DatanoiseFzf', { clear = true })
  vim.api.nvim_create_autocmd('User', {
    group = 'DatanoiseFzf',
    pattern = 'FzfStatusLine',
    callback = function()
      vim.cmd('hi! fzf1 ctermfg=darkyellow ctermbg=242 guifg=gold3 guibg=#202020 gui=none')
      vim.cmd('hi! fzf2 ctermfg=23 ctermbg=242 guifg=#CCCCCC guibg=#202020 gui=none')
      vim.cmd('hi! fzf3 ctermfg=237 ctermbg=242 guifg=#CCCCCC guibg=#202020 gui=none')
      vim.opt_local.statusline = '%#fzf1#\\ >\\ %#fzf2#fz%#fzf3#f'
    end,
  })
end

local function configure_pickers()
  local has_fzf = vim.fn.isdirectory(vim.fn.expand('~/.vim/lazy/plugins/fzf-lua')) == 1

  local function ensure_fzf()
    require('lazy').load({ plugins = { 'fzf-lua' } })
    return require('fzf-lua')
  end

  local function pick_symbols()
    local lsp_symbols = false
    local local_clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
    for _, client in ipairs(local_clients) do
      if client.server_capabilities.documentSymbolProvider then
        lsp_symbols = true
        break
      end
    end
    if lsp_symbols then
      if has_fzf then
        ensure_fzf().lsp_document_symbols()
      else
        print("No symbol picker configured")
      end
    elseif has_fzf then
      ensure_fzf().btags()
    else
      print("No LSP symbols available. Please install fzf-lua for tag picking")
    end
  end

  if has_fzf then
    vim.keymap.set("n", "<M-N>", function(opts)
      local fzf = ensure_fzf()
      opts = opts or {}
      opts.prompt = "Document Symbols"
      opts.actions = {
        ['default'] = function(selected)
          require('aerial.fzf').goto_symbol(selected[1])
        end,
      }
      fzf.fzf_exec(require('aerial.fzf').get_labels(), opts)
    end, { desc = "Document Symbols" })
  end

  vim.keymap.set("n", "<M-.>", pick_symbols, { desc = "Pick symbols" })
  vim.keymap.set("n", "<leader>n", pick_symbols, { desc = "Pick symbols" })

  if has_fzf then
    vim.keymap.set("n", "<M-;>", "<Cmd>FzfLua builtin<CR>", { silent = true, desc = "Browse FzfLua pickers" })
    vim.keymap.set("n", "<M-n>", "<Cmd>FzfLua lsp_document_symbols<CR>", { silent = true, desc = "Document Symbols" })
    vim.keymap.set("n", "<M-,>", "<Cmd>FzfLua buffers<CR>", { silent = true, desc = "Pick buffers" })
    vim.keymap.set("n", "<M-m>", "<Cmd>FzfLua files<CR>", { silent = true, desc = "Pick files" })
    vim.keymap.set("n", "<M-F>", "<Cmd>FzfLua files cwd=%:h<CR>", { silent = true, desc = "Pick local files" })
    vim.keymap.set("n", "<M-o>", "<Cmd>FzfLua oldfiles<CR>", { silent = true, desc = "Pick old files" })
    vim.keymap.set("n", "<M-g>", "<Cmd>FzfLua git_status<CR>", { silent = true, desc = "Git changes" })
    vim.keymap.set("n", "<leader>m", "<Cmd>FzfLua files<CR>", { silent = true, desc = "Pick files" })
    vim.keymap.set("n", "<leader>l", "<Cmd>FzfLua buffers<CR>", { silent = true, desc = "Pick buffers" })
  end

  if has_fzf then
    vim.keymap.set("n", "<M-b>", "<Cmd>FzfLua git_branches<CR>", { silent = true, desc = "Git branches" })
  end

  local function switch_prev_buf()
    local prev = vim.fn.bufname('#')
    if prev ~= '__InputList__' and vim.fn.bufloaded(prev) ~= 0 then
      vim.cmd('buffer #')
    elseif has_fzf then
      ensure_fzf().buffers()
    end
  end

  vim.keymap.set('n', '<C-tab>', switch_prev_buf, { silent = true })
  vim.keymap.set('n', '<C-^>', switch_prev_buf, { silent = true })
  vim.keymap.set('n', '<C-6>', switch_prev_buf, { silent = true })
end

local function configure_mini()
  require('mini.indentscope').setup({ draw = { animation = require("mini.indentscope").gen_animation.none() }, symbol = '' })
  local MiniFiles = require('mini.files')
  local MiniBufremove = require('mini.bufremove')
  MiniFiles.setup({ mappings = { go_in = '<CR>' } })
  require('mini.splitjoin').setup({ mappings = { toggle = 'gT', split = '', join = '' } })

  local miniclue = require('mini.clue')
  miniclue.setup({
    triggers = {
      { mode = 'n', keys = '<Leader>' }, { mode = 'x', keys = '<Leader>' }, { mode = 'i', keys = '<C-x>' },
      { mode = 'n', keys = 'g' }, { mode = 'x', keys = 'g' }, { mode = 'n', keys = "'" }, { mode = 'n', keys = '`' },
      { mode = 'x', keys = "'" }, { mode = 'x', keys = '`' }, { mode = 'n', keys = '"' }, { mode = 'x', keys = '"' },
      { mode = 'i', keys = '<C-r>' }, { mode = 'c', keys = '<C-r>' }, { mode = 'n', keys = '<C-w>' },
      { mode = 'n', keys = 'z' }, { mode = 'x', keys = 'z' },
    },
    clues = {
      miniclue.gen_clues.builtin_completion(), miniclue.gen_clues.g(), miniclue.gen_clues.marks(),
      miniclue.gen_clues.registers(), miniclue.gen_clues.windows(), miniclue.gen_clues.z(),
    },
  })

  MiniBufremove.setup()

  vim.keymap.set("n", "<leader>fd", MiniFiles.open, { desc = "Open file browser" })
  vim.keymap.set("n", "<leader>q", MiniBufremove.delete, { desc = "Delete Buffer" })
  configure_pickers()
end

return {
  { 'junegunn/fzf', build = './install --all' },
  { 'junegunn/fzf.vim', init = initialize_fzf_vim, cmd = { 'FZF', 'Files', 'Buffers', 'GFiles', 'History', 'Helptags', 'Rg', 'Ag', 'BLines', 'Lines' } },
  { 'ibhagwan/fzf-lua', dependencies = { 'junegunn/fzf', 'nvim-lua/plenary.nvim' }, cmd = 'FzfLua', config = configure_fzf_lua },
  { 'phaazon/hop.nvim', keys = { { '<leader>fg', '<Cmd>HopWord<CR>', silent = true, desc = "Hop words" } }, opts = {} },
  { 'echasnovski/mini.nvim', dependencies = { 'stevearc/aerial.nvim' }, config = configure_mini },
  { 'stevearc/oil.nvim',
    keys = {
      { '-', '<Cmd>Oil<CR>', desc = "Open parent directory" },
      { 'g-', function() require('oil').toggle_float() end, desc = "Toggle parent directory" },
    },
    cmd = 'Oil',
    opts = {
      float = { padding = 2, max_width = 0.5, max_height = 0.5, border = "rounded" },
      keymaps = { ["q"] = { "actions.close", mode = "n" } },
    },
  },
  { 'stevearc/aerial.nvim', opts = {} },
  { 'kevinhwang91/nvim-bqf', ft = 'qf', opts = { preview = { auto_preview = false } } },
  { 'stevearc/quicker.nvim', ft = 'qf', opts = {} },
}
