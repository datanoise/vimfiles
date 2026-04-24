if not vim.g.plugs['minuet-ai.nvim'] then
    return
end

require('minuet').setup {
    -- virtualtext = {
    --     auto_trigger_ft = {},
    --     keymap = {
    --         -- accept whole completion
    --         accept = '<A-A>',
    --         -- accept one line
    --         accept_line = '<A-a>',
    --         -- accept n lines (prompts for number)
    --         -- e.g. "A-z 2 CR" will accept 2 lines
    --         accept_n_lines = '<A-z>',
    --         -- Cycle to prev completion item, or manually invoke completion
    --         prev = '<A-[>',
    --         -- Cycle to next completion item, or manually invoke completion
    --         next = '<A-]>',
    --         dismiss = '<A-e>',
    --     },
    -- },
    lsp = {
        enabled_ft = { 'lua', 'ruby', 'vim' },
        completion = {
            -- Enables automatic completion triggering using `vim.lsp.completion.enable`
            enabled_auto_trigger_ft = { 'lua', 'ruby', '' },
        },
        inline_completion = {
            enable = true,
            enabled_auto_trigger_ft = { 'ruby', 'lua', 'vim' },
        },
    },
    provider = 'openai_fim_compatible',
    n_completions = 1, -- recommend for local model for resource saving
    -- I recommend beginning with a small context window size and incrementally
    -- expanding it, depending on your local computing power. A context window
    -- of 512, serves as an good starting point to estimate your computing
    -- power. Once you have a reliable estimate of your local computing power,
    -- you should adjust the context window to a larger value.
    context_window = 512,
    provider_options = {
        openai_fim_compatible = {
            -- For Windows users, TERM may not be present in environment variables.
            -- Consider using APPDATA instead.
            api_key = 'TERM',
            name = 'Ollama',
            end_point = 'http://localhost:11434/v1/completions',
            -- model = 'qwen2.5-coder:7b',
            model = 'qwen3-coder:480b-cloud',
            optional = {
                max_tokens = 56,
                top_p = 0.9,
            },
        },
        gemini = {
            model = 'gemini-2.0-flash',
            -- system = "see [Prompt] section for the default value",
            -- few_shots = "see [Prompt] section for the default value",
            -- chat_input = "See [Prompt Section for default value]",
            stream = true,
            api_key = 'GEMINI_API_KEY',
            end_point = 'https://generativelanguage.googleapis.com/v1beta/models',
            optional = {
                generationConfig = {
                    maxOutputTokens = 256,
                    thinkingConfig = {
                        -- Disable thinking for gemini 2.5 models
                        thinkingBudget = 0,
                        -- Disable thinking for gemini 3.x models
                        thinkingLevel = 'minimal',
                        -- Setting only one of the above options is sufficient.
                    },
                },
                safetySettings = {
                    {
                        -- HARM_CATEGORY_HATE_SPEECH,
                        -- HARM_CATEGORY_HARASSMENT
                        -- HARM_CATEGORY_SEXUALLY_EXPLICIT
                        category = 'HARM_CATEGORY_DANGEROUS_CONTENT',
                        -- BLOCK_NONE
                        threshold = 'BLOCK_ONLY_HIGH',
                    },
                },
            },
            -- a list of functions to transform the endpoint, header, and request body
            transform = {},
        },
    },
}
