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
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local cap = require("cmp_nvim_lsp").default_capabilities()

			vim.lsp.config.ruff = { capabilities = cap }
			vim.lsp.config.rust_analyzer = {
				capabilities = cap,
				settings = {
					["rust-analyzer"] = {
						inlayHints = {
							bindingModeHints = { enable = false },
							chainingHints = { enable = true },
							closingBraceHints = {
								enable = true,
								minLines = 25,
							},
							closureReturnTypeHints = { enable = "never" },
							lifetimeElisionHints = {
								enable = "never",
								useParameterNames = false,
							},
							maxLength = 25,
							parameterHints = { enable = true },
							reborrowHints = { enable = "never" },
							renderColons = true,
							typeHints = {
								enable = true,
								hideClosureInitialization = false,
								hideNamedConstructor = false,
							},
						},
					},
				},
			}
			vim.lsp.config.clangd = {
				cmd = {
					"clangd",
					"--all-scopes-completion",
					"--background-index",
					"--clang-tidy",
					"--completion-style=bundled",
					"--fallback-style=llvm",
					"--function-arg-placeholders",
					"--header-insertion=iwyu",
					"--header-insertion-decorators",
					"--log=error",
					"--offset-encoding=utf-8",
					"--pch-storage=memory",
					"--rename-file-limit=0",
                    "-j=2",
				},
				root_markers = {
					".clangd",
					".clang-tidy",
					".clang-format",
					"compile_commands.json",
					"compile_flags.txt",
					"configure.ac",
				},
				init_options = {
					usePlaceholders = true,
					completeUnimported = true,
					clangdFileStatus = true,
					fallbackFlags = { "-std=c++20" },
				},
				filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
				settings = {
					clangd = {
						InlayHints = {
							Designators = true,
							Enabled = true,
							ParameterNames = true,
							DeducedTypes = true,
						},
						fallbackFlags = { "-std=c++20" },
					},
				},
				capabilities = cap,
			}

			vim.lsp.config("lua_ls", {
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
			})

			vim.lsp.config("*", {
				root_markers = { ".git" },
				on_attach = function(client, bufnr)
				end,
				capabilities = {
					textDocument = {
						semanticTokens = {
							multilineTokenSupport = true,
						},
					},
				},
			})

			vim.lsp.enable({ "clangd", "rust_analyzer", "ruff", "lua_ls" }, true)

			vim.keymap.set({ "n", "v" }, "gra", vim.lsp.buf.code_action, { desc = "Show code actions" })
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
			vim.keymap.set("n", "gf", vim.lsp.buf.format, { desc = "Format code" })

			vim.keymap.set('n', '<leader>grh', function()
			    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
			end, { desc = "Toggle Inlay Hints" })

			-- In insert mode, use CTRL-X CTRL-O to trigger completion
		end,
	},
}
