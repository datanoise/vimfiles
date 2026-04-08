local M = {}

local function register_plug(name)
  vim.cmd(("let g:plugs[%s] = {}"):format(vim.fn.string(name)))
end

local function has_lazy_trigger(spec)
  return spec.cmd ~= nil
      or spec.ft ~= nil
      or spec.keys ~= nil
      or spec.event ~= nil
end

local function normalize_spec(spec)
  if spec.lazy == nil and not has_lazy_trigger(spec) then
    spec.lazy = false
  end
  return spec
end

local function plugin_name(spec)
  if spec.name then
    return spec.name
  end

  local repo = spec[1]
  return repo:match("/(.+)$")
end

local function bootstrap()
  local lazypath = vim.fn.expand('~/.vim/lazy/lazy.nvim')
  if vim.loop.fs_stat(lazypath) then
    return lazypath
  end

  vim.fn.mkdir(vim.fn.fnamemodify(lazypath, ':h'), 'p')

  local result = vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })

  if vim.v.shell_error ~= 0 then
    error('Failed to bootstrap lazy.nvim:\n' .. result)
  end

  return lazypath
end

function M.setup()
  local all_specs = vim.tbl_map(normalize_spec, require('plugins'))
  local root = vim.fn.expand('~/.vim/lazy/plugins')

  if vim.fn.exists('g:plugs') == 0 then
    vim.g.plugs = vim.empty_dict()
  end

  for _, spec in ipairs(all_specs) do
    local name = plugin_name(spec)
    if spec.lazy == false and vim.loop.fs_stat(root .. '/' .. name) then
      register_plug(name)
    end
  end

  vim.opt.rtp:prepend(bootstrap())

  require('lazy').setup(all_specs, {
    defaults = {
      lazy = true,
    },
    install = {
      missing = false,
    },
    root = root,
    lockfile = vim.fn.expand('~/.vim/lazy-lock.json'),
    ui = {
      size = { width = 1, height = 1 },
      border = 'none',
      backdrop = 100,
      wrap = false,
      pills = false,
    },
  })
end

return M
