return {
    {
        -- This plugin enhances the . command by allowing other custom commands to run
        "tpope/vim-repeat",
    },
    {
        -- This plugin manages vim sessions
        "tpope/vim-obsession",
    },
    {
        -- A broken plugin to use multi cursors
        "mg979/vim-visual-multi",
    },
    {
        -- Just a simple tabline plugin, no bloat
        'alvarosevilla95/luatab.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('luatab').setup({})
        end
    },
    {
        -- A notification manager plugin
        "rcarriga/nvim-notify",
        config = function()
            require("notify").setup({
                render = "compact",
            })
        end,
    },
    {
        -- A smooth scroll plugin
        "karb94/neoscroll.nvim",
        -- Disable neoscroll in neovide
        cond = vim.g.neovide == nil,
        opts = {},
    },
    {
        -- Highlight TODO and other types of comments
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
    },
    {
        -- Enhances neovim fold functionality
        "kevinhwang91/nvim-ufo",
        dependencies = { "kevinhwang91/promise-async" },
        config = function()
            require('ufo').setup({
                provider_selector = function(bufnr, filetype, buftype)
                    return { 'treesitter', 'indent' }
                end
            })
        end
    },
    {
        -- A file tree plugin
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-tree/nvim-web-devicons", -- optional, but recommended
        },
        lazy = false,                      -- neo-tree will lazily load itself
        config = function()
            require("neo-tree").setup({
                -- Sync neo-tree clipboard with neotree instances in the current neovim invocation
                clipboard = {
                    sync = "global",
                },
            })
            vim.keymap.set("n", "\\", ":Neotree filesystem toggle<CR>", { desc = "Open filesystem" })
        end,
    },
    {
        -- Breadcrumb plugin
        'Bekaboo/dropbar.nvim',
        -- optional, but required for fuzzy finder support
        dependencies = {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release --target install'
        },
        config = function()
            local dropbar_api = require('dropbar.api')
            vim.keymap.set('n', '<Leader>;', dropbar_api.pick, { desc = 'Pick symbols in winbar' })
            vim.keymap.set('n', '[;', dropbar_api.goto_context_start, { desc = 'Go to start of current context' })
            vim.keymap.set('n', '];', dropbar_api.select_next_context, { desc = 'Select next context' })
        end
    },
    {
        -- This plugin adds fuzzy searching in command line
        "gelguy/wilder.nvim",
        dependencies = { "romgrk/fzy-lua-native" },
        config = function()
            local wilder = require("wilder")
            -- Disable Python remote plugin
            wilder.set_option("use_python_remote_plugin", 0)

            wilder.set_option("pipeline", {
                wilder.branch(
                    wilder.cmdline_pipeline({
                        fuzzy = 1,
                        fuzzy_filter = wilder.lua_fzy_filter(),
                    }),
                    wilder.vim_search_pipeline()
                ),
            })

            wilder.set_option(
                "renderer",
                wilder.renderer_mux({
                    [":"] = wilder.popupmenu_renderer({
                        highlighter = wilder.lua_fzy_highlighter(),
                        left = {
                            " ",
                            wilder.popupmenu_devicons(),
                        },
                        right = {
                            " ",
                            wilder.popupmenu_scrollbar(),
                        },
                    }),
                    ["/"] = wilder.wildmenu_renderer({
                        highlighter = wilder.lua_fzy_highlighter(),
                    }),
                })
            )

            wilder.setup({
                modes = { ":", "/", "?" },
                enter_cmdline_enter = 0, -- Press <Tab> to trigger wilder.nvim
            })
        end,
    },
    {
        -- This plugin manages Cargo crates
        "saecki/crates.nvim",
        tag = "stable",
        event = { "BufRead Cargo.toml" },
        config = function()
            local crates = require("crates")
            local opts = { silent = true }

            vim.keymap.set("n", "<leader>ct", crates.toggle, opts)
            vim.keymap.set("n", "<leader>cr", crates.reload, opts)

            vim.keymap.set("n", "<leader>cv", crates.show_versions_popup, opts)
            vim.keymap.set("n", "<leader>cf", crates.show_features_popup, opts)
            vim.keymap.set("n", "<leader>cd", crates.show_dependencies_popup, opts)

            vim.keymap.set("n", "<leader>cu", crates.update_crate, opts)
            vim.keymap.set("v", "<leader>cu", crates.update_crates, opts)
            vim.keymap.set("n", "<leader>ca", crates.update_all_crates, opts)
            vim.keymap.set("n", "<leader>cU", crates.upgrade_crate, opts)
            vim.keymap.set("v", "<leader>cU", crates.upgrade_crates, opts)
            vim.keymap.set("n", "<leader>cA", crates.upgrade_all_crates, opts)

            vim.keymap.set("n", "<leader>cx", crates.expand_plain_crate_to_inline_table, opts)
            vim.keymap.set("n", "<leader>cX", crates.extract_crate_into_table, opts)

            vim.keymap.set("n", "<leader>cH", crates.open_homepage, opts)
            vim.keymap.set("n", "<leader>cR", crates.open_repository, opts)
            vim.keymap.set("n", "<leader>cD", crates.open_documentation, opts)
            vim.keymap.set("n", "<leader>cC", crates.open_crates_io, opts)
            vim.keymap.set("n", "<leader>cL", crates.open_lib_rs, opts)

            crates.setup()
        end,
    },
    {
        -- A nice plugins which adds a lot of tweaks
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        config = function()
            require("noice").setup({
                cmdline = { view = "cmdline" },
                lsp = {
                    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
                    },
                },
                popupmenu = {
                    enabled = false,
                },
                -- you can enable a preset for easier configuration
                presets = {
                    bottom_search = true,         -- use a classic bottom cmdline for search
                    command_palette = true,       -- position the cmdline and popupmenu together
                    long_message_to_split = true, -- long messages will be sent to a split
                    inc_rename = false,           -- enables an input dialog for inc-rename.nvim
                    lsp_doc_border = false,       -- add a border to hover docs and signature help
                },
            })
        end,
    },
}
