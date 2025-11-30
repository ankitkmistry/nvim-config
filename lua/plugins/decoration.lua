return {
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('lualine').setup ({
                -- options = { theme = 'gruvbox' }
                options = { theme = 'horizon' }
            })
        end
    },
    {
        "catppuccin/nvim", 
        lazy = false,
        name = "catppuccin", 
        priority = 1000,
        config = function()
            vim.cmd.colorscheme "catppuccin"
        end
    },
    {
        "goolord/alpha-nvim",
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            local theme = require("alpha.themes.theta")
            theme.file_icons.provider = "devicons"
            require("alpha").setup(theme.config)
        end,
    }
}
