return {
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		---@module "ibl"
		---@type ibl.config
		opts = {},
		config = function()
			require("ibl").setup({
				scope = {
					show_start = false,
					show_end = false,
				},
			})
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons", "meuter/lualine-so-fancy.nvim" },
		config = function()
			require("lualine").setup({
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff", "diagnostics" },
					lualine_c = { "filename", "fancy_macro" },
					lualine_x = { "%S", "encoding", "fileformat", "filetype" },
					lualine_y = { "progress", "selectioncount" },
					lualine_z = { "location" },
				},
			})
		end,
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
		end,
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
		config = function()
			require("tokyonight").setup({
				transparent = false,
			})
			-- vim.cmd.colorscheme("tokyonight-night")
		end,
	},
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
		config = function()
			require("kanagawa").setup({
				transparent = false,
				background = {
					dark = "wave",
					light = "lotus",
				},
			})
			-- vim.cmd.colorscheme("kanagawa")
		end,
	},
	{
		"miikanissi/modus-themes.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("modus-themes").setup({
				-- Theme comes in two styles `modus_operandi` and `modus_vivendi`
				-- `auto` will automatically set style based on background set with vim.o.background
				style = "auto",
                -- Theme comes in four variants `default`, `tinted`, `deuteranopia`, and `tritanopia`
				variant = "tinted",
                -- Transparent background (as supported by the terminal)
				transparent = true,
                -- "non-current" windows are dimmed
				dim_inactive = false,
                -- Hide statuslines on inactive windows. Works with the standard **StatusLine**, **LuaLine** and **mini.statusline**
				hide_inactive_statusline = false,
                -- Distinct background colors in line number column. `false` will disable background color and fallback to Normal background
				line_nr_column_background = true,
                -- Distinct background colors in sign column. `false` will disable background color and fallback to Normal background
				sign_column_background = true,
                -- Style to be applied to different syntax groups
                -- Value is any valid attr-list value for `:help nvim_set_hl`
				styles = {
					comments = { italic = true },
					keywords = { italic = true },
					functions = {},
					variables = {},
				},
				--- You can override specific color groups to use other groups or a hex color
				--- Function will be called with a ColorScheme table
				--- Refer to `extras/lua/modus_operandi.lua` or `extras/lua/modus_vivendi.lua` for the ColorScheme table
				---@param colors ColorScheme
				on_colors = function(colors) end,
				--- You can override specific highlights to use other groups or a hex color
				--- Function will be called with a Highlights and ColorScheme table
				--- Refer to `extras/lua/modus_operandi.lua` or `extras/lua/modus_vivendi.lua` for the Highlights and ColorScheme table
				---@param highlights Highlights
				---@param colors ColorScheme
				on_highlights = function(highlights, colors) end,
			})
            -- Activate the theme
			vim.cmd.colorscheme("modus")
		end,
	},
	{
		"goolord/alpha-nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
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
