return {
    {
        "williamboman/mason.nvim",
        config = function()
            require('mason').setup()
        end
    },
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {},
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            "neovim/nvim-lspconfig",
        },
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            vim.lsp.config('ruff', {})
            vim.keymap.set({'n', 'v'}, 'gra', vim.lsp.buf.code_action, { desc = 'Show code actions' })
            vim.keymap.set('n', 'grd', vim.lsp.buf.definition, { desc = 'Go to definition' })
            vim.keymap.set('n', 'gri', vim.lsp.buf.implementation, { desc = 'Show implementations' })
            vim.keymap.set('n', 'grn', vim.lsp.buf.rename, { desc = 'Rename symbol' })
            vim.keymap.set('n', 'grr', vim.lsp.buf.references, { desc = 'Show references' })
            vim.keymap.set('n', 'grt', vim.lsp.buf.type_definition, { desc = 'Show type defintion' })
            vim.keymap.set('n', 'gO', vim.lsp.buf.document_symbol, { desc = 'List all symbols' })
            vim.keymap.set('i', '<C-s>', vim.lsp.buf.signature_help, { desc = 'Show signature help' })

            vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "Show hover information" })
            -- vim.keymap.set('n', 'gq', vim.lsp.format, { desc = "Format code" })

            -- In insert mode, use CTRL-X CTRL-O to trigger completion
            -- This enables features like go-to-definition and keymaps like CTRL-], CTRL-W_], CTRL-W_} to utilize the language server
            -- Format lines via 'gq'
        end
    }
}
