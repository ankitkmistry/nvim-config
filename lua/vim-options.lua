vim.cmd("set nocompatible")     -- No comments
vim.cmd("set encoding=utf-8")	-- Set encoding to utf-8
vim.cmd("colorscheme darkblue") -- Set colorscheme

vim.cmd("set number")          --  Line numbers
vim.cmd("set relativenumber")  -- Relative line numbers

vim.cmd("syntax on")                   -- Syntax highlighting
vim.cmd("filetype plugin indent on")   -- Enable filetype detection and indentation
vim.cmd("set showmatch")               -- Show matching brackets

-- Auto-read files changed outside Vim
vim.cmd("set autoread")
vim.cmd("autocmd FocusGained,BufEnter * checktime")

-- Highlight search results
vim.cmd("set hlsearch")
vim.cmd("set incsearch")

-- Case-insensitive search unless uppercase is used
vim.cmd("set ignorecase")
vim.cmd("set smartcase")

vim.cmd("set ruler")                   -- Show ruler (line, col)
vim.cmd("set mouse=a")                 -- Enable mouse support
vim.cmd("set wrap")                    -- Enable line wrapping
vim.cmd("set scrolloff=5")             -- Keep 5 lines visible when scrolling
vim.cmd("set showcmd")                 -- Show typed commands
vim.cmd("set showcmdloc=statusline")   -- Show commands in status line
vim.cmd("set laststatus=2")            -- Always show status line
vim.cmd("set wildmenu")                -- Better auto completion
vim.cmd("set noswapfile")              -- Disable swap files
vim.cmd("set history=1000")            -- Keep longer history
vim.cmd("set clipboard=unnamedplus")   -- Use system clipboard

-- Indentation
vim.cmd("set tabstop=4")       -- Tabs look like 4 spaces
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")    -- Auto-indent uses 4 spaces
vim.cmd("set expandtab")       -- Convert tabs to spaces
vim.cmd("set smartindent")     -- Smart auto-indentation

vim.g.mapleader = " "   -- Space as the map leader
vim.g.maplocalleader = " "  
vim.g.have_nerd_font = true

-- Take confirmation when doing dangerous tasks
vim.o.confirm = true
-- Always have rounded borders for popup windows
vim.o.winborder = "rounded"

-- Enable extended colors
vim.opt.termguicolors = true
-- Do not show mode, since it is already shown in the status line
vim.opt.showmode = false
-- Save undo history
vim.opt.undofile = true
-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'
-- Show which line cursor is on
vim.opt.cursorline = true
-- Help some scrolling
vim.opt.scrolloff = 10
-- Help with search highlighting
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })

-- Terminal ones
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})
