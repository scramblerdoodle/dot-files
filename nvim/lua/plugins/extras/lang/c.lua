--
-- See
-- https://sourceware.org/gdb/current/onlinedocs/gdb.html/Interpreters.html
-- https://sourceware.org/gdb/current/onlinedocs/gdb.html/Debugger-Adapter-Protocol.html
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
    id = 'gdb',
    type = 'executable',
    command = 'gdb',
    args = { '--quiet', '--interpreter=dap' "--eval-command", "set print pretty on"},
}
			dap.configurations.c = {
    {
        name = 'Run executable (GDB)',
        type = 'gdb',
        request = 'launch',
        -- This requires special handling of 'run_last', see
        -- https://github.com/mfussenegger/nvim-dap/issues/1025#issuecomment-1695852355
        program = function()
            local path = vim.fn.input({
                prompt = 'Path to executable: ',
                default = vim.fn.getcwd() .. '/',
                completion = 'file',
            })

            return (path and path ~= '') and path or dap.ABORT
        end,
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


}
