return {
    {
        'nvim-telescope/telescope.nvim', tag = 'v0.2.0',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Search [G]it files' })

            vim.keymap.set('n', '<leader>ph', builtin.help_tags,        { desc = 'Search [H]elp' })
            vim.keymap.set('n', '<leader>pk', builtin.keymaps,          { desc = 'Search [K]eymaps' })
            vim.keymap.set('n', '<leader>pf', builtin.find_files,       { desc = 'Search [F]iles' })
            vim.keymap.set('n', '<leader>ps', builtin.builtin,          { desc = 'Search [S]elect Telescope' })
            vim.keymap.set('n', '<leader>pw', builtin.grep_string,      { desc = 'Search current [W]ord' })
            vim.keymap.set('n', '<leader>pg', builtin.live_grep,        { desc = 'Search by [G]rep' })
            vim.keymap.set('n', '<leader>pr', builtin.resume,           { desc = 'Search [R]esume' })
            vim.keymap.set('n', '<leader>pd', builtin.diagnostics,      { desc = 'Search [D]iagnostics' })
            vim.keymap.set('n', '<leader>pm', builtin.man_pages,        { desc = 'Search [M]an pages' })
            vim.keymap.set('n', '<leader>p.', builtin.oldfiles,         { desc = 'Search Recent Files ("." for repeat)' })
            vim.keymap.set('n', '<leader><leader>', builtin.buffers,    { desc = '[ ] Find existing buffers' })

            vim.keymap.set('n', '<leader>pn', '<cmd>Telescope notify<CR>', { desc = 'Show notifications' })

            vim.keymap.set('n', '<leader>plr', builtin.lsp_references,           { desc = 'Show [L]SP [R]eferences' })
            vim.keymap.set('n', '<leader>plsd', builtin.lsp_document_symbols,     { desc = 'Show [L]SP [D]ocument symbols' })
            vim.keymap.set('n', '<leader>plsw', builtin.lsp_workspace_symbols,    { desc = 'Show [L]SP [W]orkspace symbols' })
            vim.keymap.set('n', '<leader>pli', builtin.lsp_implementations,      { desc = 'Show [L]SP [I]mplementations' })
            vim.keymap.set('n', '<leader>pld', builtin.lsp_definitions,          { desc = 'Show [L]SP [D]efinitions' })
            vim.keymap.set('n', '<leader>plt', builtin.lsp_type_definitions,     { desc = 'Show [L]SP [T]ype definitions' })
        end
    },
    {
        'nvim-telescope/telescope-ui-select.nvim',
        config = function() 
            -- This is your opts table
            require("telescope").setup {
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown {
                            -- even more opts
                        }

                        -- pseudo code / specification for writing custom displays, like the one
                        -- for "codeactions"
                        -- specific_opts = {
                        --   [kind] = {
                        --     make_indexed = function(items) -> indexed_items, width,
                        --     make_displayer = function(widths) -> displayer
                        --     make_display = function(displayer) -> function(e)
                        --     make_ordinal = function(e) -> string
                        --   },
                        --   -- for example to disable the custom builtin "codeactions" display
                        --      do the following
                        --   codeactions = false,
                        -- }
                    }
                }
            }
            -- To get ui-select loaded and working with telescope, you need to call
            -- load_extension, somewhere after setup function:
            require("telescope").load_extension("ui-select")
        end
    }
}
