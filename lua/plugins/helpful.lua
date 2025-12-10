return {
    {
        "tpope/vim-repeat",
    },
    {
        "nvim-mini/mini.surround",
    },
    {
        "rcarriga/nvim-notify",
    },
    {
        "gelguy/wilder.nvim",
        dependencies = { "romgrk/fzy-lua-native" },
        config = function() 
            local wilder = require('wilder')
            wilder.setup({
                modes = {':', '/', '?'},
                enter_cmdline_enter = 0, -- Press <Tab> to trigger wilder.nvim
            })
            -- Disable Python remote plugin
            wilder.set_option('use_python_remote_plugin', 0)

            wilder.set_option('pipeline', {
                wilder.branch(
                    wilder.cmdline_pipeline({
                        fuzzy = 1,
                        fuzzy_filter = wilder.lua_fzy_filter(),
                    }),
                    wilder.vim_search_pipeline()
                )
            })

            wilder.set_option('renderer', wilder.renderer_mux({
                [':'] = wilder.popupmenu_renderer({
                    highlighter = wilder.lua_fzy_highlighter(),
                    left = {
                        ' ',
                        wilder.popupmenu_devicons()
                    },
                    right = {
                        ' ',
                        wilder.popupmenu_scrollbar()
                    },
                }),
                ['/'] = wilder.wildmenu_renderer({
                    highlighter = wilder.lua_fzy_highlighter(),
                }),
            })) 
        end,
    },
    {
        "MysticalDevil/inlay-hints.nvim",
        event = "LspAttach",
        dependencies = { "neovim/nvim-lspconfig" },
        config = function()
            require("inlay-hints").setup({
                commands = { enable = true }, -- Enable InlayHints commands, include `InlayHintsToggle`, `InlayHintsEnable` and `InlayHintsDisable`
                autocmd = { enable = true } -- Enable the inlay hints on `LspAttach` event
            })
        end
    },
    {
        "folke/trouble.nvim",
        opts = {}, -- for default options, refer to the configuration section for custom setup.
        cmd = "Trouble",
        keys = {
            { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",                          desc = "Trouble diagnostics", },
            { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",             desc = "Trouble buffer diagnostics", },
            { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>",                  desc = "Trouble symbols", },
            { "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",   desc = "Trouble definitions, references, ...", },
            { "<leader>xl", "<cmd>Trouble loclist toggle<cr>",                              desc = "Trouble location list", },
            { "<leader>xq", "<cmd>Trouble qflist toggle<cr>",                               desc = "Trouble quickfix list", },
        },
    },
    {
        "Pocco81/auto-save.nvim",
        config = function()
            require('auto-save').setup({
                enabled = true, -- start auto-save when the plugin is loaded (i.e. when your package manager loads it)
                execution_message = {
                    message = function() -- message to print on save
                        return "saved..."
                    end,
                    dim = 0.18, -- dim the color of `message`
                    cleaning_interval = 1250, -- (milliseconds) automatically clean MsgArea after displaying `message`. See :h MsgArea
                },
                trigger_events = {"InsertLeave", "TextChanged"}, -- vim events that trigger auto-save. See :h events
                -- function that determines whether to save the current buffer or not
                -- return true: if buffer is ok to be saved
                -- return false: if it's not ok to be saved
                condition = function(buf)
                    local fn = vim.fn
                    local utils = require("auto-save.utils.data")

                    if fn.getbufvar(buf, "&modifiable") == 1 
                        and utils.not_in(fn.getbufvar(buf, "&filetype"), {}) then
                        return true -- met condition(s), can save
                    end
                    return false -- can't save
                end,
                -- write_all_buffers = false, -- write all buffers when the current one meets `condition`
                write_all_buffers = true, -- write all buffers when the current one meets `condition`
                debounce_delay = 135, -- saves the file at most every `debounce_delay` milliseconds
                callbacks = { -- functions to be executed at different intervals
                    enabling = nil, -- ran when enabling auto-save
                    disabling = nil, -- ran when disabling auto-save
                    before_asserting_save = nil, -- ran before checking `condition`
                    before_saving = nil, -- ran before doing the actual save
                    after_saving = nil -- ran after doing the actual save
                }
            })
        end
    }
}
