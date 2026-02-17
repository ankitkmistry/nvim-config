return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {},
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            "neovim/nvim-lspconfig",
        },
        config = function()
            require("mason-lspconfig").setup {
                ensure_installed = {
                    "clangd",
                    "lua_ls",
                    "rust_analyzer",
                    "ruff",
                },
            }
        end
    },
    {
        "neovim/nvim-lspconfig", -- REQUIRED: for native Neovim LSP integration
        lazy = false,            -- REQUIRED: tell lazy.nvim to start this plugin at startup
        dependencies = {
            -- main one
            { "ms-jpq/coq_nvim",       branch = "coq" },
            -- 9000+ Snippets
            { "ms-jpq/coq.artifacts",  branch = "artifacts" },
            -- lua & third party sources -- See https://github.com/ms-jpq/coq.thirdparty
            -- Need to **configure separately**
            { 'ms-jpq/coq.thirdparty', branch = "3p" }
            -- - shell repl
            -- - nvim lua api
            -- - scientific calculator
            -- - comment banner
            -- - etc
        },
        init = function()
            vim.g.coq_settings = {
                auto_start = true,
            }
        end,
        config = function()
            -- LSP settings are here
            local coq = require('coq')

            vim.lsp.config('clangd', coq.lsp_ensure_capabilities())
            vim.lsp.config('rust_analyzer', coq.lsp_ensure_capabilities())
            vim.lsp.config('lua_ls', coq.lsp_ensure_capabilities())
            vim.lsp.config('ruff', coq.lsp_ensure_capabilities())

            vim.lsp.config("*", {
                root_markers = { ".git" },
                on_attach = function(client, bufnr) end,
                capabilities = {
                    textDocument = {
                        semanticTokens = {
                            multilineTokenSupport = true,
                        },
                    },
                },
            })

            vim.lsp.enable({ "clangd", "rust_analyzer", "ruff", "lua_ls" }, true)

            vim.keymap.set("n", "gra", vim.lsp.buf.code_action, { desc = "Show code actions" })
            vim.keymap.set("n", "grd", vim.lsp.buf.definition, { desc = "Go to definition" })
            vim.keymap.set("n", "gri", vim.lsp.buf.implementation, { desc = "Show implementations" })
            vim.keymap.set("n", "grn", vim.lsp.buf.rename, { desc = "Rename symbol" })
            vim.keymap.set("n", "grr", vim.lsp.buf.references, { desc = "Show references" })
            vim.keymap.set("n", "grt", vim.lsp.buf.type_definition, { desc = "Show type defintion" })
            vim.keymap.set("n", "gO", vim.lsp.buf.document_symbol, { desc = "List all symbols" })
            vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help, { desc = "Show signature help" })

            vim.keymap.set("n", "K", function()
                vim.lsp.buf.hover({ border = "rounded" })
            end, { desc = "Show hover information" })
            vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "Format code" })

            vim.keymap.set("n", "<leader>grh", function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
            end, { desc = "Toggle Inlay Hints" })

            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "grs", builtin.lsp_document_symbols, { desc = "Show [L]SP [D]ocument symbols" })
        end,
    },
}
