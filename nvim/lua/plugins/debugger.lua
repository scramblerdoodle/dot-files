return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			dapui.setup()

			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end

			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end

			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end

			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end

			-- Keybinds
			local wk = require("which-key")
			wk.add({ "<leader>d", group = "debugger" })

			-- Start Debugger
			vim.keymap.set("n", "<leader>dc", function()
				dap.continue()
			end, { desc = "Start Debugger" })

			-- Toggle Breakpoint
			vim.keymap.set("n", "<leader>db", function()
				dap.toggle_breakpoint()
			end, { desc = "Toggle Breakpoint" })

			-- Set Breakpoint with Log ?
			vim.keymap.set("n", "<leader>dB", function()
				dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
			end, { desc = "Set Breakpoint with Log" })

			-- Run last ?
			vim.keymap.set("n", "<leader>dl", function()
				dap.run_last()
			end, { desc = "Run Last" })

			-- Step Over in Debugger
			vim.keymap.set("n", "<leader>dn", function()
				dap.step_over()
			end, { desc = "Step Over" })

			-- Step Into in Debugger
			vim.keymap.set("n", "<leader>ds", function()
				dap.step_into()
			end, { desc = "Step Into" })

			-- Step Out in Debugger
			vim.keymap.set("n", "<leader>dr", function()
				dap.step_out()
			end, { desc = "Step Out" })

			-- Open REPL
			vim.keymap.set("n", "<Leader>dR", function()
				require("dap").repl.open()
			end, { desc = "Open REPL" })

			-- Unknown or Buggy Commands
			-- vim.keymap.set({ "n", "v" }, "<leader>dh", function() require("dap.ui.widgets").hover() end, { desc = "Hover" }) vim.keymap.set({ "n", "v" }, "<leader>dp", function() require("dap.ui.widgets").preview() end, { desc = "Preview" }) vim.keymap.set("n", "<leader>df", function() local widgets = require("dap.ui.widgets") widgets.centered_float(widgets.frames) end, { desc = "Frame" })
			-- vim.keymap.set("n", "<leader>ds", function() local widgets = require("dap.ui.widgets") widgets.centered_float(widgets.scopes) end, { desc = "Scopes" })

			dap.adapters.gdb = {
				type = "executable",
				command = "gdb",
				args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
			}
			dap.configurations.c = {
				{
					name = "Launch",
					type = "gdb",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopAtBeginningOfMainSubprogram = false,
				},
				{
					name = "Attach to gdbserver :1234",
					type = "gdb",
					request = "attach",
					target = "localhost:1234",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
				},
			}
		end,
	},

	{
		"mfussenegger/nvim-dap-python",
		ft = "python",
		dependencies = {
			"mfussenegger/nvim-dap",
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
			require("dap-python").setup(path)
			require("dap-python").test_runner = "pytest"
		end,
	},
}
