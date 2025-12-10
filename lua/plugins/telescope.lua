return {
    {
        'nvim-telescope/telescope.nvim', tag = 'v0.2.0',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Search git files' })
            vim.keymap.set('i', '', '<cmd>Telescope git_files<CR>', { desc = 'Search git files' })

            vim.keymap.set('n', '<leader>fh', builtin.help_tags,        { desc = 'Search [H]elp' })
            vim.keymap.set('n', '<leader>fk', builtin.keymaps,          { desc = 'Search [K]eymaps' })
            vim.keymap.set('n', '<leader>ff', builtin.find_files,       { desc = 'Search [F]iles' })
            vim.keymap.set('n', '<leader>fs', builtin.builtin,          { desc = 'Search [S]elect Telescope' })
            vim.keymap.set('n', '<leader>fw', builtin.grep_string,      { desc = 'Search current [W]ord' })
            vim.keymap.set('n', '<leader>fg', builtin.live_grep,        { desc = 'Search by [G]rep' })
            vim.keymap.set('n', '<leader>fr', builtin.resume,           { desc = 'Search [R]esume' })
            vim.keymap.set('n', '<leader>fd', builtin.diagnostics,      { desc = 'Search [D]iagnostics' })
            vim.keymap.set('n', '<leader>fm', builtin.man_pages,        { desc = 'Search [M]an pages' })
            vim.keymap.set('n', '<leader>f.', builtin.oldfiles,         { desc = 'Search Recent Files ("." for repeat)' })
            vim.keymap.set('n', '<leader><leader>', builtin.buffers,    { desc = '[ ] Find existing buffers' })

            vim.keymap.set('n', '<leader>fn', '<cmd>Telescope notify<CR>', { desc = 'Show notifications' })

            vim.keymap.set('n', '<leader>lr', builtin.lsp_references,           { desc = 'Show [L]SP [R]eferences' })
            vim.keymap.set('n', '<leader>ld', builtin.lsp_document_symbols,     { desc = 'Show [L]SP [D]ocument symbols' })
            vim.keymap.set('n', '<leader>lw', builtin.lsp_workspace_symbols,    { desc = 'Show [L]SP [W]orkspace symbols' })
            vim.keymap.set('n', '<leader>li', builtin.lsp_implementations,      { desc = 'Show [L]SP [I]mplementations' })
            vim.keymap.set('n', '<leader>ld', builtin.lsp_definitions,          { desc = 'Show [L]SP [D]efinitions' })
            vim.keymap.set('n', '<leader>lt', builtin.lsp_type_definitions,     { desc = 'Show [L]SP [T]ype definitions' })
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
