return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons", -- optional, but recommended
	},
	lazy = false, -- neo-tree will lazily load itself
	config = function()
		require("neo-tree").setup({
            -- Sync neo-tree clipboard with neotree instances in the current neovim invocation
			clipboard = {
				sync = "global",
			},
		})

		vim.keymap.set("n", "<leader>ex", ":Neotree filesystem toggle<CR>", { desc = "Open filesystem" })
	end,
}
