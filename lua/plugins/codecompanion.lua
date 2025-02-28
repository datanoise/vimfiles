if not vim.g.plugs['codecompanion.nvim'] then
    return
end

local codecompanion = require("codecompanion")
codecompanion.setup({
  display = {
    inline = {
      layout = "vertical",
    },
    chat = {
      window = {
        layout = "vertical",
      },
    },
    action_palette = {
      width = 95,
      height = 10,
      prompt = "Prompt ", -- Prompt used for interactive LLFidget calls
      provider = "mini_pick", -- default|telescope|mini_pick
      opts = {
        show_default_actions = true, -- Show the default actions in the action palette?
        show_default_prompt_library = true, -- Show the default prompt library in the action palette?
      },
    },
    diff = {
      layout = "vertical",
      provider = "mini_diff",
    },
  },
  strategies = {
    chat = {
      adapter = 'gemini-flash',
      keymaps = {
        close = {
          modes = {
            n = "q",
            i = "<C-c>",
          },
          index = 3,
          callback = function()
            codecompanion.toggle()
          end,
          description = "Toggle Chat",
        },
        stop = {
          modes = {
            n = "<C-s",
          },
          index = 4,
          callback = "keymaps.stop",
          description = "Stop Request",
        },
        send = {
          modes = { n = "<M-j>", i = "<M-j>" },
        },
      },
      slash_commands = {
        ["help"] = {
          opts = {
            provider = "mini_pick",
          },
        },
      },
    },
  },
  adapters = {
    ollamalocal = function()
      return require('codecompanion.adapters').extend('ollama', {
        name = 'ollamalocal',
        schema = {
          model = {
            default = 'llama3.2:latest',
          },
        },
      })
    end,
    gemini = function()
      return require('codecompanion.adapters').extend('gemini', {
        name = 'gemini-flash',
        schema = {
          model = {
            default = 'gemini-2.0-flash',
          },
        },
        env = {
          api_key = 'cmd:op read op://personal/Gemini/credential --no-newline',
        }
      })
    end,
    anthropic = function()
      return require('codecompanion.adapters').extend('anthropic', {
        name = 'anthropic',
        env = {
          api_key = 'cmd:op read op://personal/Anthropic/credential --no-newline',
        }
      })
    end,
  },
  opts = {
    -- Set debug logging
    log_level = "DEBUG",
  },
})

vim.keymap.set("n", "<leader>cc", codecompanion.chat, { desc = "Open Chat" })

local progress = require("fidget.progress")

local Fidget = {}

function Fidget:init()
  local group = vim.api.nvim_create_augroup("CodeCompanionFidgetHooks", {})

  vim.api.nvim_create_autocmd({ "User" }, {
    pattern = "CodeCompanionRequestStarted",
    group = group,
    callback = function(request)
      local handle = Fidget:create_progress_handle(request)
      Fidget:store_progress_handle(request.data.id, handle)
    end,
  })

  vim.api.nvim_create_autocmd({ "User" }, {
    pattern = "CodeCompanionRequestFinished",
    group = group,
    callback = function(request)
      local handle = Fidget:pop_progress_handle(request.data.id)
      if handle then
        Fidget:report_exit_status(handle, request)
        handle:finish()
      end
    end,
  })
end

Fidget.handles = {}

function Fidget:store_progress_handle(id, handle)
  Fidget.handles[id] = handle
end

function Fidget:pop_progress_handle(id)
  local handle = Fidget.handles[id]
  Fidget.handles[id] = nil
  return handle
end

function Fidget:create_progress_handle(request)
  return progress.handle.create({
    title = " Requesting assistance (" .. request.data.strategy .. ")",
    message = "In progress...",
    lsp_client = {
      name = Fidget:llm_role_title(request.data.adapter),
    },
  })
end

function Fidget:llm_role_title(adapter)
  local parts = {}
  table.insert(parts, adapter.formatted_name)
  if adapter.model and adapter.model ~= "" then
    table.insert(parts, "(" .. adapter.model .. ")")
  end
  return table.concat(parts, " ")
end

function Fidget:report_exit_status(handle, request)
  if request.data.status == "success" then
    handle.message = "Completed"
  elseif request.data.status == "error" then
    handle.message = " Error"
  else
    handle.message = "󰜺 Cancelled"
  end
end

Fidget:init()

