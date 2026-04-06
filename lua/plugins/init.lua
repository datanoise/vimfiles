local specs = {}

for _, module in ipairs({
  'plugins.core',
  'plugins.navigation',
  'plugins.ui',
  'plugins.lsp',
  'plugins.completion',
  'plugins.testing',
}) do
  vim.list_extend(specs, require(module))
end

return specs
