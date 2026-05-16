if not vim.g.plugs['nvim-treesitter'] then
  return
end

pcall(vim.treesitter.language.register, 'embedded_template', 'eruby')

require('nvim-ts-autotag').setup({
  aliases = {
    eruby = 'html',
  },
})

local group = vim.api.nvim_create_augroup('datanoise_treesitter', { clear = true })

vim.api.nvim_create_autocmd('FileType', {
  group = group,
  pattern = {
    'c',
    'eruby',
    'html',
    'javascript',
    'lua',
    'python',
    'ruby',
    'rust',
    'sql',
    'typescript',
    'vim',
    'xml',
  },
  callback = function(args)
    pcall(vim.treesitter.start, args.buf)

    vim.wo.foldmethod = 'expr'
    vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

    if not vim.tbl_contains({ 'eruby', 'ruby', 'rust', 'vim' }, vim.bo[args.buf].filetype) then
      vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})

if vim.g.plugs['nvim-treesitter-textobjects'] then
  require('nvim-treesitter-textobjects').setup({
    select = {
      lookahead = true,
      selection_modes = {
        ['@parameter.outer'] = 'v',
        ['@function.outer'] = 'V',
        ['@class.outer'] = '<c-v>',
      },
      include_surrounding_whitespace = false,
    },
    move = {
      set_jumps = true,
    },
  })

  local select = require('nvim-treesitter-textobjects.select')
  local move = require('nvim-treesitter-textobjects.move')
  local swap = require('nvim-treesitter-textobjects.swap')

  vim.keymap.set({ 'x', 'o' }, 'af', function()
    select.select_textobject('@function.outer', 'textobjects')
  end)
  vim.keymap.set({ 'x', 'o' }, 'if', function()
    select.select_textobject('@function.inner', 'textobjects')
  end)
  vim.keymap.set({ 'x', 'o' }, 'ac', function()
    select.select_textobject('@class.outer', 'textobjects')
  end)
  vim.keymap.set({ 'x', 'o' }, 'ic', function()
    select.select_textobject('@class.inner', 'textobjects')
  end)
  vim.keymap.set({ 'x', 'o' }, 'as', function()
    select.select_textobject('@local.scope', 'locals')
  end)

  vim.keymap.set('n', '<leader>>', function()
    swap.swap_next('@parameter.inner')
  end)
  vim.keymap.set('n', '<leader><', function()
    swap.swap_previous('@parameter.inner')
  end)

  vim.keymap.set({ 'n', 'x', 'o' }, ']m', function()
    move.goto_next_start('@function.outer', 'textobjects')
  end)
  vim.keymap.set({ 'n', 'x', 'o' }, ']]', function()
    move.goto_next_start('@class.outer', 'textobjects')
  end)
  vim.keymap.set({ 'n', 'x', 'o' }, ']M', function()
    move.goto_next_end('@function.outer', 'textobjects')
  end)
  vim.keymap.set({ 'n', 'x', 'o' }, '][', function()
    move.goto_next_end('@class.outer', 'textobjects')
  end)
  vim.keymap.set({ 'n', 'x', 'o' }, '[m', function()
    move.goto_previous_start('@function.outer', 'textobjects')
  end)
  vim.keymap.set({ 'n', 'x', 'o' }, '[[', function()
    move.goto_previous_start('@class.outer', 'textobjects')
  end)
  vim.keymap.set({ 'n', 'x', 'o' }, '[M', function()
    move.goto_previous_end('@function.outer', 'textobjects')
  end)
  vim.keymap.set({ 'n', 'x', 'o' }, '[]', function()
    move.goto_previous_end('@class.outer', 'textobjects')
  end)
end

if vim.g.plugs['nvim-treesitter-context'] then
  require('treesitter-context').setup({
    max_lines = 2,
  })
end
