if not vim.g.plugs['nvim-colorizer.lua'] then
  return
end

require'colorizer'.setup {
  'css';
  'scss';
  'html';
}
