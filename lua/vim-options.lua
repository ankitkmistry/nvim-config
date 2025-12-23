vim.cmd("set nocompatible") -- No comments
vim.cmd("set encoding=utf-8") -- Set encoding to utf-8

vim.cmd("set number") --  Line numbers
vim.cmd("set relativenumber") -- Relative line numbers

vim.cmd("syntax on") -- Syntax highlighting
vim.cmd("filetype plugin indent on") -- Enable filetype detection and indentation
vim.cmd("set showmatch") -- Show matching brackets

-- Auto-read files changed outside Vim
vim.cmd("set autoread")
vim.cmd("autocmd FocusGained,BufEnter * checktime")

-- Highlight search results
vim.cmd("set hlsearch")
vim.cmd("set incsearch")

-- Case-insensitive search unless uppercase is used
vim.cmd("set ignorecase")
vim.cmd("set smartcase")

vim.cmd("set ruler") -- Show ruler (line, col)
vim.cmd("set mouse=a") -- Enable mouse support
vim.cmd("set wrap") -- Enable line wrapping
vim.cmd("set scrolloff=5") -- Keep 5 lines visible when scrolling
vim.cmd("set showcmd") -- Show typed commands
vim.cmd("set showcmdloc=statusline") -- Show commands in status line
vim.cmd("set laststatus=2") -- Always show status line
vim.cmd("set wildmenu") -- Better auto completion
vim.cmd("set noswapfile") -- Disable swap files
vim.cmd("set history=1000") -- Keep longer history
vim.cmd("set clipboard=unnamedplus") -- Use system clipboard

-- Indentation
vim.cmd("set tabstop=4") -- Tabs look like 4 spaces
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4") -- Auto-indent uses 4 spaces
vim.cmd("set expandtab") -- Convert tabs to spaces
vim.cmd("set smartindent") -- Smart auto-indentation

vim.g.mapleader = " " -- Space as the map leader
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

-- Take confirmation when doing dangerous tasks
vim.o.confirm = true

-- Enable extended colors
vim.opt.termguicolors = true
-- Do not show mode, since it is already shown in the status line
vim.opt.showmode = false
-- Save undo history
vim.opt.undofile = true
-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"
-- Show which line cursor is on
vim.opt.cursorline = true
-- Help some scrolling
vim.opt.scrolloff = 10
-- Help with search highlighting
vim.opt.hlsearch = true

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- diagnostic
local diagnostic_goto = function(next, severity)
	return function()
		vim.diagnostic.jump({
			count = (next and 1 or -1) * vim.v.count1,
			severity = severity and vim.diagnostic.severity[severity] or nil,
			float = true,
		})
	end
end

-- Keymaps
vim.keymap.set("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })
vim.keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Disable search highlighting" })
vim.keymap.set("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
vim.keymap.set("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

-- Windows
vim.keymap.set("n", "<leader>ws", "<C-w>s", { desc = "Open horizontal split" })
vim.keymap.set("n", "<leader>wv", "<C-w>v", { desc = "Open vertical split" })
vim.keymap.set("n", "<leader>wc", "<C-w>c", { desc = "Close window" })
vim.keymap.set("n", "<leader>wo", "<C-w>o", { desc = "Close all other windows" })

vim.keymap.set("n", "<leader>ww", "<C-w><C-w>", { desc = "Move to next window" })
vim.keymap.set("n", "<leader>w<Up>", "<C-w><Up>", { desc = "Move to up window" })
vim.keymap.set("n", "<leader>wk", "<C-w>k", { desc = "Move to up window" })
vim.keymap.set("n", "<leader>w<Down>", "<C-w><Down>", { desc = "Move to down window" })
vim.keymap.set("n", "<leader>wj", "<C-w>j", { desc = "Move to down window" })
vim.keymap.set("n", "<leader>w<Left>", "<C-w><Left>", { desc = "Move to left window" })
vim.keymap.set("n", "<leader>wh", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<leader>w<Right>", "<C-w><Right>", { desc = "Move to right window" })
vim.keymap.set("n", "<leader>wl", "<C-w>l", { desc = "Move to right window" })

vim.keymap.set("n", "<leader>wr", "<C-w>r", { desc = "Rotate windows downwards/rightwards" })
vim.keymap.set("n", "<leader>wR", "<C-w>R", { desc = "Rotate windows upwards/leftwards" })
vim.keymap.set("n", "<leader>wK", "<C-w>K", { desc = "Move window up" })
vim.keymap.set("n", "<leader>wJ", "<C-w>J", { desc = "Move window bottom" })
vim.keymap.set("n", "<leader>wH", "<C-w>H", { desc = "Move window left" })
vim.keymap.set("n", "<leader>wL", "<C-w>L", { desc = "Move window right" })

vim.keymap.set("n", "<leader>w=", "<C-w>=", { desc = "Make windows equal size" })
vim.keymap.set("n", "<leader>w+", "<C-w>+", { desc = "Decrease window height" })
vim.keymap.set("n", "<leader>w-", "<C-w>-", { desc = "Increase window height" })
vim.keymap.set("n", "<leader>w<", "<C-w><", { desc = "Decrease window width" })
vim.keymap.set("n", "<leader>w>", "<C-w>>", { desc = "Increase window height" })

vim.keymap.set("n", "<leader>w]", "<C-w>]", { desc = "Open in new window and go" })
vim.keymap.set("n", "<leader>wf", "<C-w>f", { desc = "Open file in new window" })
vim.keymap.set("n", "<leader>wF", "<C-w>F", { desc = "Open file at line in new window" })
vim.keymap.set("n", "<leader>wt", "<C-w>T", { desc = "Open window in new tab" })

-- Tabs
vim.keymap.set("n", "tn", "<cmd>tabnew<cr>", { desc = "New tab" })
vim.keymap.set("n", "te", "<cmd>tabedit<cr>", { desc = "Edit in new tab" })
vim.keymap.set("n", "tc", "<cmd>tabclose<cr>", { desc = "Close tab" })
vim.keymap.set("n", "to", "<cmd>tabonly<cr>", { desc = "Close all other tabs" })
vim.keymap.set("n", "tm", ":tab ", { desc = "Run cmd in new tab" })

-- Back and Forth
vim.keymap.set("n", "]q", vim.cmd.cnext, { desc = "Next Quickfix" })
vim.keymap.set("n", "[q", vim.cmd.cprev, { desc = "Previous Quickfix" })

vim.keymap.set("n", "]d", diagnostic_goto(true), { desc = "Next diagnostic" })
vim.keymap.set("n", "[d", diagnostic_goto(false), { desc = "Previous diagnostic" })
vim.keymap.set("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next error" })
vim.keymap.set("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Previous error" })
vim.keymap.set("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next warning" })
vim.keymap.set("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Previous warning" })

vim.keymap.set("n", "]t", function()
	require("todo-comments").jump_next()
end, { desc = "Next todo comment" })
vim.keymap.set("n", "[t", function()
	require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })

-- Terminal
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
