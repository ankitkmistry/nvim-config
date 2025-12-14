return {
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        ---@module "ibl"
        ---@type ibl.config
        opts = {},
        config = function() 
            require("ibl").setup {
                scope = {
                    show_start = false,
                    show_end = false,
                },
            }
        end
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('lualine').setup {
                sections = {
                    lualine_a = {'mode'},
                    lualine_b = {'branch', 'diff', 'diagnostics'},
                    lualine_c = {'filename'},
                    lualine_x = {'%S', 'encoding', 'fileformat', 'filetype'},
                    lualine_y = {'progress', 'selectioncount', 'searchcount'},
                    lualine_z = {'location'}
                }, 
            }
        end
    },
    {
        "catppuccin/nvim", 
        lazy = false,
        name = "catppuccin", 
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavour = "mocha", -- latte, frappe, macchiato, mocha
                background = { -- :h background
                    light = "latte",
                    dark = "mocha",
                },
                transparent_background = false, -- disables setting the background color.
                float = {
                    transparent = false, -- enable transparent floating windows
                    rounded = true,
                    -- solid = false, -- use solid styling for floating windows, see |winborder|
                },
                show_end_of_buffer = true, -- shows the '~' characters after the end of buffers
                -- term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
                dim_inactive = {
                    enabled = false, -- dims the background color of inactive window
                    shade = "dark",
                    percentage = 0.15, -- percentage of the shade to apply to the inactive window
                },
                no_italic = false, -- Force no italic
                no_bold = false, -- Force no bold
                no_underline = false, -- Force no underline
                -- styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
                --     comments = { "italic" }, -- Change the style of comments
                --     conditionals = { "italic" },
                --     loops = {},
                --     functions = {},
                --     keywords = {},
                --     strings = {},
                --     variables = {},
                --     numbers = {},
                --     booleans = {},
                --     properties = {},
                --     types = {},
                --     operators = {},
                --     -- miscs = {}, -- Uncomment to turn off hard-coded styles
                -- },
                lsp_styles = { -- Handles the style of specific lsp hl groups (see `:h lsp-highlight`).
                    virtual_text = {
                        errors = { "italic" },
                        hints = { "italic" },
                        warnings = { "italic" },
                        information = { "italic" },
                        ok = { "italic" },
                    },
                    underlines = {
                        errors = { "underline" },
                        hints = { "underline" },
                        warnings = { "underline" },
                        information = { "underline" },
                        ok = { "underline" },
                    },
                    inlay_hints = {
                        background = true,
                    },
                },
                color_overrides = {},
                custom_highlights = {},
                default_integrations = true,
                auto_integrations = true,
                integrations = {
                    alpha = true,
                    cmp = true,
                    gitsigns = true,
                    neotree = true,
                    notify = false,
                },
            })

            -- setup must be called before loading
            -- vim.cmd.colorscheme "catppuccin"
        end
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
        config = function() 
            vim.cmd.colorscheme "tokyonight-night"
        end
    },
    {
        "goolord/alpha-nvim",
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            local theme = require("alpha.themes.theta")
            theme.file_icons.provider = "devicons"
            -- theme.header.val = {
            --     [[███▄▄▄▄      ▄████████  ▄██████▄   ▄█    █▄   ▄█    ▄▄▄▄███▄▄▄▄  ]], 
            --     [[███▀▀▀██▄   ███    ███ ███    ███ ███    ███ ███  ▄██▀▀▀███▀▀▀██▄]], 
            --     [[███   ███   ███    █▀  ███    ███ ███    ███ ███▌ ███   ███   ███]], 
            --     [[███   ███  ▄███▄▄▄     ███    ███ ███    ███ ███▌ ███   ███   ███]], 
            --     [[███   ███ ▀▀███▀▀▀     ███    ███ ███    ███ ███▌ ███   ███   ███]], 
            --     [[███   ███   ███    █▄  ███    ███ ███    ███ ███  ███   ███   ███]], 
            --     [[███   ███   ███    ███ ███    ███ ███    ███ ███  ███   ███   ███]], 
            --     [[ ▀█   █▀    ██████████  ▀██████▀   ▀██████▀  █▀    ▀█   ███   █▀ ]], 
            -- }
            theme.header.val = {
                [[▄▄▄    ▄▄▄  ▄▄▄▄▄▄▄   ▄▄▄▄▄   ▄▄▄▄  ▄▄▄▄ ▄▄▄▄▄ ▄▄▄      ▄▄▄]], 
                [[████▄  ███ ███▀▀▀▀▀ ▄███████▄ ▀███  ███▀  ███  ████▄  ▄████]], 
                [[███▀██▄███ ███▄▄    ███   ███  ███  ███   ███  ███▀████▀███]], 
                [[███  ▀████ ███      ███▄▄▄███  ███▄▄███   ███  ███  ▀▀  ███]], 
                [[███    ███ ▀███████  ▀█████▀    ▀████▀   ▄███▄ ███      ███]], 
            }

            require("alpha").setup(theme.config)
        end,
    },
}
