return {
    settings = {
        Lua = {
            workspace = {
                -- This line tells lua-ls to include Neovim's runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            diagnostics = {
                -- This line tells lua-ls to recognize the `vim` global
                globals = { "vim" },
            },
        },
    },
}
