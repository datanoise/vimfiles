" Comment.nvim settings
if !has_key(g:plugs, 'Comment.nvim')
  finish
endif

lua require('Comment').setup()
