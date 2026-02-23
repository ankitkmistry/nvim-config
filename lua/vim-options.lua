-- Enable extended colors
vim.opt.termguicolors = true
-- I have a nerd font
vim.g.have_nerd_font = true

-- ========================================================
-- OPTIONS
-- ========================================================
-- Line, cursor and scrolling
vim.wo.number = true         -- Line numbers
vim.wo.relativenumber = true -- Relative line numbers
vim.opt.cursorline = true    -- Show which line cursor is on
vim.o.wrap = true            -- Enable line wrapping
vim.o.scrolloff = 4          -- Keep 4 lines visible when scrolling
vim.o.sidescrolloff = 8      -- Keep 8 cols visible when side scrolling

-- Indentation
vim.o.tabstop = 4        -- Tabs look like 4 spaces
vim.o.softtabstop = 4    -- No tabs on tab/backspace
vim.o.shiftwidth = 4     -- Auto-indent uses 4 spaces
vim.o.expandtab = true   -- Convert tabs to spaces
vim.o.smartindent = true -- Smart auto-indentation
vim.o.autoindent = true  -- Copy indent from current line

-- Searching
vim.o.ignorecase = true -- Ignore case
vim.o.smartcase = true  -- Unless uppercase is used
vim.o.hlsearch = true   -- Highlight search results
vim.o.incsearch = true  -- Do incremental search

-- Window options
vim.o.signcolumn = "auto:1" -- Keep signcolumn on by default
-- vim.o.colorcolumn = "150"   -- Show a visual line at column 100
vim.o.showmatch = true      -- Show matching brackets
vim.o.showmode = false -- Do not show mode status line already has it
vim.o.pumheight = 6    -- Popup menu height
vim.o.pumblend = 10    -- Popup menu transparency
-- vim.o.winblend = 10         -- Floating window transparency
vim.o.conceallevel = 0 -- Do not use conceal feature
vim.o.concealcursor = ""
vim.o.fillchars = "eob:~,fold: ,foldopen:,foldsep: ,foldclose:"
vim.opt.diffopt:append("linematch:60") -- Improve diff display

-- Backup options
vim.opt.backup = false      -- Do not create backup file
vim.opt.writebackup = false -- Do not write to backup file
vim.opt.swapfile = false    -- Do not create swapfile
vim.opt.undofile = true     -- Save undo history
vim.opt.autoread = true     -- Auto reload changes to a file
vim.opt.autowrite = false   -- Do not auto save

-- Key event options
vim.o.updatetime = 300  -- Faster completion
vim.o.ttimeoutlen = 500 -- Key code timeout

-- Folding
vim.o.foldcolumn = "1"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- Command line
vim.o.wildmenu = true                -- Enable command line completion
vim.o.wildmode = "longest:full,full" -- Wildmenu opts
vim.o.history = 1000                 -- Keep longer history

-- Status line
vim.o.ruler = true              -- Show ruler (line, col)
vim.o.showcmd = true            -- Show typed commands
vim.o.showcmdloc = "statusline" -- Show commands in status line
vim.o.laststatus = 2            -- Always show status line

-- Other options
vim.opt.encoding = "utf-8"              -- Set encoding to utf-8
vim.opt.hidden = true                   -- Allow hidden buffers
vim.opt.backspace = "indent,eol,start"  -- Better backspace behaviour
vim.opt.autochdir = false               -- Do not auto change directories
vim.opt.path:append("**")               -- Include subdirs in "gf" and "gF" command search
vim.opt.selection = "inclusive"         -- Include last character in selection
vim.opt.mouse = "a"                     -- Enable mouse support
vim.opt.clipboard:append("unnamedplus") -- Use system clipboard
vim.opt.maxmempattern = 20000           -- Let nvim use more memory
vim.opt.confirm = true                  -- Take confirmation when doing dangerous tasks

vim.cmd("syntax on")                    -- Syntax highlighting
vim.cmd("filetype plugin indent on")    -- Enable filetype detection and indentation

-- Space as the map leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ========================================================
-- AUTOCMDS
-- ========================================================
local augroup = vim.api.nvim_create_augroup("UserConfig", { clear = true })

-- Highlight when yanking text
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking text",
    group = augroup,
    callback = function()
        vim.hl.on_yank()
    end,
})

-- Return to last cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
    desc = "Restore last cursor position",
    group = augroup,
    callback = function()
        -- Do not use in diff mode
        if vim.o.diff then return end
        -- (row, col)
        local last_pos = vim.api.nvim_buf_get_mark(0, '"')
        local last_line = vim.api.nvim_buf_line_count(0)
        -- Get the line and check if it is correct
        local row = last_pos[1]
        if row < 1 or row > last_line then return end
        -- Set the cursor
        pcall(vim.api.nvim_win_set_cursor, 0, last_pos)
    end,
})

-- ========================================================
-- KEYMAPS
-- ========================================================
-- Essential
vim.keymap.set("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })
vim.keymap.set("n", "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })
vim.keymap.set("n", "<A-s>", "<cmd>wa<cr><esc>", { desc = "Save all" })
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Disable search highlighting" })

-- Pasting and deleting without yanking
vim.keymap.set("x", "<leader>p", '"_dP', { desc = "Paste without yanking" })
vim.keymap.set({ "n", "v" }, "<leader>x", '"_d', { desc = "Delete without yanking" })

-- Comments
vim.keymap.set("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
vim.keymap.set("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

-- Buffers
vim.keymap.set("n", "gb", "<cmd>bnext<CR>", { desc = "Go to next buffer" })
vim.keymap.set("n", "gB", "<cmd>bprev<CR>", { desc = "Go to previous buffer" })

vim.api.nvim_create_user_command("BufOnly", function()
    vim.cmd('%bdelete | edit # | normal `"')
end, { desc = "Close all other buffers" })
vim.keymap.set("n", "<leader>bo", "<cmd>BufOnly<CR>", { desc = "Close all other buffers" })

-- Indenting
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Windows
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to up window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to down window" })
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

vim.keymap.set("n", "<leader>ws", "<C-w>s", { desc = "Open horizontal split" })
vim.keymap.set("n", "<leader>wv", "<C-w>v", { desc = "Open vertical split" })
vim.keymap.set("n", "<leader>wc", "<C-w>c", { desc = "Close window" })
vim.keymap.set("n", "<leader>wq", "<C-w>q", { desc = "Quit window" })
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
vim.keymap.set("n", "<leader>w|", "<C-w>|", { desc = "Max window width" })
vim.keymap.set("n", "<leader>w_", "<C-w>_", { desc = "Max window height" })
vim.keymap.set("n", "<leader>w<", "<C-w><", { desc = "Decrease window width" })
vim.keymap.set("n", "<leader>w>", "<C-w>>", { desc = "Increase window width" })
vim.keymap.set("n", "<leader>w+", "<C-w>+", { desc = "Decrease window height" })
vim.keymap.set("n", "<leader>w-", "<C-w>-", { desc = "Increase window height" })

vim.keymap.set("n", "<leader>w]", "<C-w>]", { desc = "Open in new window and go" })
vim.keymap.set("n", "<leader>wf", "<C-w>f", { desc = "Open file in new window" })
vim.keymap.set("n", "<leader>wF", "<C-w>F", { desc = "Open file at line in new window" })
vim.keymap.set("n", "<leader>wt", "<C-w>T", { desc = "Open window in new tab" })

-- Tabs
vim.keymap.set("n", "<leader>tn", "<cmd>tabnew<cr>", { desc = "New tab" })
vim.keymap.set("n", "<leader>te", "<cmd>tabedit<cr>", { desc = "Edit in new tab" })
vim.keymap.set("n", "<leader>tc", "<cmd>tabclose<cr>", { desc = "Close tab" })
vim.keymap.set("n", "<leader>to", "<cmd>tabonly<cr>", { desc = "Close all other tabs" })
vim.keymap.set("n", "<leader>tm", ":tab ", { desc = "Run cmd in new tab" })

-- Terminal
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Back and Forth
vim.keymap.set("n", "]q", vim.cmd.cnext, { desc = "Next Quickfix" })
vim.keymap.set("n", "[q", vim.cmd.cprev, { desc = "Previous Quickfix" })

-- Diagnostics
local diagnostic_goto = function(next, severity)
    return function()
        vim.diagnostic.jump({
            count = (next and 1 or -1) * vim.v.count1,
            severity = severity and vim.diagnostic.severity[severity] or nil,
            float = true,
        })
    end
end

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
