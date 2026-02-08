return {
	{
		"tpope/vim-repeat",
	},
	{
		"tpope/vim-obsession",
	},
	{
		"mg979/vim-visual-multi",
	},
	{
		"rcarriga/nvim-notify",
		config = function()
			require("notify").setup({
				render = "compact",
			})
		end,
	},
	{
		"karb94/neoscroll.nvim",
		-- Disable neoscroll in neovide
		cond = vim.g.neovide == nil,
		opts = {},
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		config = function()
			require("noice").setup({
				cmdline = {
					view = "cmdline",
					format = {
						search_down = {
							view = "cmdline",
						},
						search_up = {
							view = "cmdline",
						},
					},
				},
				lsp = {
					-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
					},
				},
				-- you can enable a preset for easier configuration
				presets = {
					bottom_search = true, -- use a classic bottom cmdline for search
					command_palette = true, -- position the cmdline and popupmenu together
					long_message_to_split = true, -- long messages will be sent to a split
					inc_rename = false, -- enables an input dialog for inc-rename.nvim
					lsp_doc_border = false, -- add a border to hover docs and signature help
				},
			})
		end,
	},
	{
		"gelguy/wilder.nvim",
		dependencies = { "romgrk/fzy-lua-native" },
		config = function()
			local wilder = require("wilder")
			-- Disable Python remote plugin
			-- wilder.set_option("use_python_remote_plugin", 1)

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
		"folke/trouble.nvim",
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Trouble diagnostics",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Trouble buffer diagnostics",
			},
			{ "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Trouble symbols" },
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "Trouble definitions, references, ...",
			},
			{
				"<leader>xl",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Trouble location list",
			},
			{
				"<leader>xq",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Trouble quickfix list",
			},
		},
	},
	{
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
}
