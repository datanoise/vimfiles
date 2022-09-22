if not vim.g.plugs['Comment.nvim'] then
    return
end

require('Comment').setup()
require('Comment.ft').set('eruby.yaml', '# %s')
