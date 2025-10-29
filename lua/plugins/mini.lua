if not vim.g.plugs['mini.nvim'] then
    return
end

require('mini.indentscope').setup({
    draw = { animation = require("mini.indentscope").gen_animation.none() },
    symbol = ''
})
require('mini.files').setup({
    mappings = {
        go_in = '<CR>',
    },
})
require('mini.pick').setup()
require('mini.extra').setup()
require('mini.splitjoin').setup({
    mappings = {
        toggle = 'gT',
        split = '',
        join = '',
    },
})
-- require('mini.diff').setup()
local miniclue = require('mini.clue')
miniclue.setup({
    triggers = {
        -- Leader triggers
        { mode = 'n', keys = '<Leader>' },
        { mode = 'x', keys = '<Leader>' },

        -- Built-in completion
        { mode = 'i', keys = '<C-x>' },

        -- `g` key
        { mode = 'n', keys = 'g' },
        { mode = 'x', keys = 'g' },

        -- Marks
        { mode = 'n', keys = "'" },
        { mode = 'n', keys = '`' },
        { mode = 'x', keys = "'" },
        { mode = 'x', keys = '`' },

        -- Registers
        { mode = 'n', keys = '"' },
        { mode = 'x', keys = '"' },
        { mode = 'i', keys = '<C-r>' },
        { mode = 'c', keys = '<C-r>' },

        -- Window commands
        { mode = 'n', keys = '<C-w>' },

        -- `z` key
        { mode = 'n', keys = 'z' },
        { mode = 'x', keys = 'z' },
    },

    clues = {
        -- Enhance this by adding descriptions for <Leader> mapping groups
        miniclue.gen_clues.builtin_completion(),
        miniclue.gen_clues.g(),
        miniclue.gen_clues.marks(),
        miniclue.gen_clues.registers(),
        miniclue.gen_clues.windows(),
        miniclue.gen_clues.z(),
    },
})
require('mini.bufremove').setup()

local MiniPick = require('mini.pick')

local function buffers_mru()
    -- Get all listed buffers with their last used time
    local buffers = vim.tbl_filter(function(buf)
        return buf.listed == 1
    end, vim.fn.getbufinfo({ buflisted = 1 }))

    -- Sort by lastused (most recent first)
    table.sort(buffers, function(a, b)
        return a.lastused > b.lastused
    end)

    -- Get current working directory for relative paths
    local cwd = vim.fn.getcwd()
    local cur_buf_id = vim.api.nvim_get_current_buf()

    -- Format items like the standard implementation
    local items = {}
    for _, buf in ipairs(buffers) do
        if buf.bufnr ~= cur_buf_id then
            local name = buf.name
            if name == '' then
                name = '[No Name]'
            else
                -- Make path relative to cwd if possible
                if vim.startswith(name, cwd) then
                    name = vim.fn.fnamemodify(name, ':.')
                else
                    name = vim.fn.fnamemodify(name, ':~')
                end
            end

            table.insert(items, { text = name, bufnr = buf.bufnr })
        end
    end

    -- Get the show function - use show_with_icons like the standard implementation
    local show = function(buf_id, i, query) MiniPick.default_show(buf_id, i, query, { show_icons = true }) end

    -- Define wipeout function and mappings
    local wipeout_cur = function()
        local bufnr = MiniPick.get_picker_matches().current.bufnr
        vim.api.nvim_buf_delete(bufnr, {})

        -- Refresh by restarting the picker
        MiniPick.stop()
        vim.schedule(function()
            buffers_mru() -- Call the function again to rebuild the list
        end)
    end
    local buffer_mappings = { wipeout = { char = '<C-x>', func = wipeout_cur } }

    local opts = {
        source = {
            name = 'Buffers (MRU)',
            items = items,
            show = show
        },
        mappings = buffer_mappings,
    }

    return MiniPick.start(opts)
end
MiniPick.registry.buffers_mru = buffers_mru

local function git_changes()
    local items = {}
    local handle = io.popen("git status --porcelain=v1")
    if handle then
        for line in handle:lines() do
            -- The first two characters of `git status --porcelain` indicate file status
            -- M: Modified, A: Added, D: Deleted, etc.
            local status = line:sub(1, 2)
            local filename = line:sub(4)
            table.insert(items, {
                path = filename,
                text = string.format("[%s] %s", status, filename),
            })
        end
        handle:close()
    end

    -- Get the show function - use show_with_icons like the standard implementation
    local show = function(buf_id, i, query) MiniPick.default_show(buf_id, i, query, { show_icons = true }) end
    local opts = {
        source = {
            name = 'Git Changes',
            items = items,
            show = show
        },
    }

    return MiniPick.start(opts)
end
MiniPick.registry.git_changes = git_changes

vim.keymap.set("n", "<leader>fd", MiniFiles.open, { desc = "Open file browser" })
vim.keymap.set("n", "<leader>q", MiniBufremove.delete, { desc = "Delete Buffer" })
