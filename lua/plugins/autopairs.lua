if not vim.g.plugs['nvim-autopairs'] then
    return
end

require("nvim-autopairs").setup {
  ignored_next_char = [=[[%w%%%'%[%"]]=]
}

local Rule = require('nvim-autopairs.rule')
local npairs = require('nvim-autopairs')
local cond = require('nvim-autopairs.conds')

npairs.add_rules {
    Rule(' ', ' ')
        :with_pair(function (opts)
            local pair = opts.line:sub(opts.col - 1, opts.col)
            return vim.tbl_contains({ '()', '[]', '{}' }, pair)
        end),
    Rule('( ', ' )')
        :with_pair(function() return false end)
        :with_move(function(opts)
            return opts.prev_char:match('.%)') ~= nil
        end)
        :use_key(')'),
    Rule('{ ', ' }')
        :with_pair(function() return false end)
        :with_move(function(opts)
            return opts.prev_char:match('.%}') ~= nil
        end)
        :use_key('}'),
    Rule('[ ', ' ]')
        :with_pair(function() return false end)
        :with_move(function(opts)
            return opts.prev_char:match('.%]') ~= nil
        end)
        :use_key(']'),
    Rule('<', '>', {'rust'})
        :with_cr(cond.none())
        :with_pair(cond.not_before_regex('%s', 1))
        :with_move(function (opts)
            return opts.next_char == '>' and opts.char == '>'
        end),
}
