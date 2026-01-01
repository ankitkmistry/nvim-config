return {
	"mfussenegger/nvim-dap",
	dependencies = {
		-- Creates a beautiful debugger UI
		"rcarriga/nvim-dap-ui",
		-- Required dependency for nvim-dap-ui
		"nvim-neotest/nvim-nio",
		-- Installs the debug adapters for you
		"mason-org/mason.nvim",
		"jay-babu/mason-nvim-dap.nvim",
	},
	config = function()
		local function merge_tables(t1, t2)
			for key, value in pairs(t2) do
				t1[key] = value
			end
			return t1
		end

		local dap = require("dap")
		local dapui = require("dapui")

		vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
		vim.keymap.set("n", "<leader>dB", function()
			dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
		end, { desc = "Debug: Set Breakpoint" })
		vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Debug: Start/Continue" })
		vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "Debug: Open REPL" })
		vim.keymap.set("n", "<leader>dq", dap.terminate, { desc = "Debug: Open REPL" })
		vim.keymap.set("n", "<leader>ds", dap.step_into, { desc = "Debug: Step Into" })
		vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Debug: Step Over" })
		vim.keymap.set("n", "<leader>du", dap.step_out, { desc = "Debug: Step Out" })
		-- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
		vim.keymap.set("n", "<leader>dt", dapui.toggle, { desc = "Debug: See last session result." })

		-- See: https://codeberg.org/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#c-c-rust-via-gdb
		dap.adapters.gdb = {
			type = "executable",
			command = "gdb",
			args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
		}
		-- See: https://codeberg.org/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#more-rust-specific-set-up
		dap.adapters["rust-gdb"] = {
			type = "executable",
			command = "rust-gdb",
			args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
		}
		-- See: https://codeberg.org/mfussenegger/nvim-dap/wiki/C-C---Rust-(via--codelldb)
		dap.adapters.codelldb = {
			type = "executable",
			command = "codelldb", -- or if not in $PATH: "/absolute/path/to/codelldb"
			-- On windows you may need to uncomment this:
			detached = vim.fn.has("win64") == 1 or vim.fn.has("win32") == 1 and false or true,
		}

		dap.configurations.cpp = {
			{
				name = "Launch",
				type = "gdb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				args = {}, -- provide arguments if needed
				cwd = "${workspaceFolder}",
				stopAtBeginningOfMainSubprogram = false,
			},
			{
				name = "Launch",
				type = "codelldb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				args = {}, -- provide arguments if needed
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
			},
		}
		dap.configurations.c = {}
		dap.configurations.rust = {
			{
				name = "Launch",
				type = "rust-gdb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				args = {}, -- provide arguments if needed
				cwd = "${workspaceFolder}",
				stopAtBeginningOfMainSubprogram = false,
			},
		}

		merge_tables(dap.configurations.c, dap.configurations.cpp)
		merge_tables(dap.configurations.rust, dap.configurations.cpp)

		require("mason-nvim-dap").setup({
			automatic_installation = true,
			-- You can provide additional configuration to the handlers,
			-- see mason-nvim-dap README for more information
			handlers = {},
			-- You'll need to check that you have the required things installed
			-- online, please don't ask me how to install them :)
			ensure_installed = {},
		})

		-- Dap UI setup
		-- For more information, see |:help nvim-dap-ui|
		dapui.setup({
			icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
			controls = {
				icons = {
					pause = "⏸",
					play = "▶",
					step_into = "⏎",
					step_over = "⏭",
					step_out = "⏮",
					step_back = "b",
					run_last = "▶▶",
					terminate = "⏹",
					disconnect = "⏏",
				},
			},
		})

		-- Change breakpoint icons
		vim.api.nvim_set_hl(0, "DapBreak", { fg = "#e51400" })
		vim.api.nvim_set_hl(0, "DapStop", { fg = "#ffcc00" })
		local breakpoint_icons = vim.g.have_nerd_font
				and {
					Breakpoint = "",
					BreakpointCondition = "",
					BreakpointRejected = "",
					LogPoint = "",
					Stopped = "",
				}
			or {
				Breakpoint = "●",
				BreakpointCondition = "⊜",
				BreakpointRejected = "⊘",
				LogPoint = "◆",
				Stopped = "⭔",
			}
		for type, icon in pairs(breakpoint_icons) do
			local tp = "Dap" .. type
			local hl = (type == "Stopped") and "DapStop" or "DapBreak"
			vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
		end

		dap.listeners.after.event_initialized["dapui_config"] = dapui.open
		dap.listeners.before.event_terminated["dapui_config"] = dapui.close
		dap.listeners.before.event_exited["dapui_config"] = dapui.close
	end,
}
