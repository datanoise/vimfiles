local function configure_bqf()
  require("bqf").setup({ preview = { auto_preview = false } })
end

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

local function configure_hop()
  require('hop').setup()
  vim.keymap.set('n', '<leader>fg', '<Cmd>HopWord<CR>', { silent = true })
end

local function configure_pickers()
  local force_fzf = false
  local has_mini_pick, MiniPick = pcall(require, 'mini.pick')
  local has_mini_extra, MiniExtra = pcall(require, 'mini.extra')
  local has_fzf = vim.fn.isdirectory(vim.fn.expand('~/.vim/lazy/plugins/fzf-lua')) == 1
  local use_mini = has_mini_pick and has_mini_extra and not force_fzf

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
      if use_mini then
        MiniExtra.pickers.lsp({ scope = 'document_symbol' })
      elseif has_fzf then
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

  if use_mini then
    vim.keymap.set("n", "<M-n>", function() MiniExtra.pickers.lsp({ scope = 'document_symbol' }) end, { desc = "Document Symbols" })
    vim.keymap.set("n", "<M-,>", MiniPick.registry.buffers_mru, { desc = "Pick buffers" })
    vim.keymap.set("n", "<M-m>", MiniPick.builtin.files, { desc = "Pick files" })
    vim.keymap.set("n", "<M-o>", MiniExtra.pickers.oldfiles, { desc = "Pick old files" })
    vim.keymap.set("n", "<M-F>", function()
      require('mini.pick').builtin.files({}, { source = { cwd = vim.fn.expand('%:p:h') } })
    end, { desc = "Pick local files" })
    vim.keymap.set("n", "<leader>m", MiniPick.builtin.files, { desc = "Pick files" })
    vim.keymap.set("n", "<leader>l", MiniPick.registry.buffers_mru, { desc = "Pick buffers" })
    vim.keymap.set("n", "<M-g>", MiniPick.registry.git_changes, { desc = "Git changes" })
  elseif has_fzf then
    vim.keymap.set("n", "<M-;>", "<Cmd>FzfLua builtin<CR>", { silent = true })
    vim.keymap.set("n", "<M-,>", "<Cmd>FzfLua buffers<CR>", { silent = true })
    vim.keymap.set("n", "<M-m>", "<Cmd>FzfLua files<CR>", { silent = true })
    vim.keymap.set("n", "<M-F>", "<Cmd>FzfLua files cwd=%:h<CR>", { silent = true })
    vim.keymap.set("n", "<M-o>", "<Cmd>FzfLua oldfiles<CR>", { silent = true })
    vim.keymap.set("n", "<leader>m", "<Cmd>FzfLua files<CR>", { silent = true })
    vim.keymap.set("n", "<leader>l", "<Cmd>FzfLua buffers<CR>", { silent = true })
  end

  if has_fzf then
    vim.keymap.set("n", "<M-b>", "<Cmd>FzfLua git_branches<CR>", { silent = true })
  end

  local function switch_prev_buf()
    local prev = vim.fn.bufname('#')
    if prev ~= '__InputList__' and vim.fn.bufloaded(prev) ~= 0 then
      vim.cmd('buffer #')
    elseif use_mini then
      MiniPick.registry.buffers_mru()
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
  require('mini.files').setup({ mappings = { go_in = '<CR>' } })
  require('mini.pick').setup()
  require('mini.extra').setup()
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

  require('mini.bufremove').setup()
  local MiniPick = require('mini.pick')

  local function buffers_mru()
    local buffers = vim.tbl_filter(function(buf) return buf.listed == 1 end, vim.fn.getbufinfo({ buflisted = 1 }))
    table.sort(buffers, function(a, b) return a.lastused > b.lastused end)
    local cwd = vim.fn.getcwd()
    local cur_buf_id = vim.api.nvim_get_current_buf()
    local items = {}
    for _, buf in ipairs(buffers) do
      if buf.bufnr ~= cur_buf_id then
        local name = buf.name
        if name == '' then
          name = '[No Name]'
        elseif vim.startswith(name, cwd) then
          name = vim.fn.fnamemodify(name, ':.')
        else
          name = vim.fn.fnamemodify(name, ':~')
        end
        table.insert(items, { text = name, bufnr = buf.bufnr })
      end
    end
    local show = function(buf_id, i, query) MiniPick.default_show(buf_id, i, query, { show_icons = true }) end
    local wipeout_cur = function()
      local bufnr = MiniPick.get_picker_matches().current.bufnr
      vim.api.nvim_buf_delete(bufnr, {})
      MiniPick.stop()
      vim.schedule(buffers_mru)
    end
    return MiniPick.start({
      source = { name = 'Buffers (MRU)', items = items, show = show },
      mappings = { wipeout = { char = '<C-x>', func = wipeout_cur }, mark = '<C-d>' },
    })
  end
  MiniPick.registry.buffers_mru = buffers_mru

  local function git_changes()
    local items = {}
    local handle = io.popen("git status --porcelain=v1")
    if handle then
      for line in handle:lines() do
        local status = line:sub(1, 2)
        local filename = line:sub(4)
        table.insert(items, { path = filename, text = string.format("[%s] %s", status, filename) })
      end
      handle:close()
    end
    local show = function(buf_id, i, query) MiniPick.default_show(buf_id, i, query, { show_icons = true }) end
    return MiniPick.start({ source = { name = 'Git Changes', items = items, show = show } })
  end
  MiniPick.registry.git_changes = git_changes

  vim.keymap.set("n", "<leader>fd", MiniFiles.open, { desc = "Open file browser" })
  vim.keymap.set("n", "<leader>q", MiniBufremove.delete, { desc = "Delete Buffer" })
  configure_pickers()
end

local function configure_oil()
  require("oil").setup({
    float = { padding = 2, max_width = 0.5, max_height = 0.5, border = "rounded" },
    keymaps = { ["q"] = { "actions.close", mode = "n" } },
  })
  vim.keymap.set("n", "-", "<Cmd>Oil<CR>", { desc = "Open parent directory" })
  vim.keymap.set("n", "g-", function() require('oil').toggle_float() end, { desc = "Toggle parent directory" })
end

return {
  { 'junegunn/fzf', build = './install --all' },
  { 'junegunn/fzf.vim' },
  { 'ibhagwan/fzf-lua', dependencies = { 'junegunn/fzf', 'nvim-lua/plenary.nvim' }, cmd = 'FzfLua', config = configure_fzf_lua },
  { 'phaazon/hop.nvim', config = configure_hop },
  { 'echasnovski/mini.nvim', dependencies = { 'stevearc/aerial.nvim' }, config = configure_mini },
  { 'stevearc/oil.nvim', config = configure_oil },
  { 'stevearc/aerial.nvim' },
  { 'kevinhwang91/nvim-bqf', config = configure_bqf },
  { 'stevearc/quicker.nvim' },
}
