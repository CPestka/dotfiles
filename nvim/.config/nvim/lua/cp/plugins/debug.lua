return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		require("dapui").setup()

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

		vim.keymap.set('n', '<Leader>dl', dap.run_last, {})
		vim.keymap.set('n', '<Leader>dc', dap.continue, {})
		vim.keymap.set("n", "<Leader>db", dap.toggle_breakpoint, {})
		vim.keymap.set("n", "<Leader>dBC", dap.clear_breakpoints, {})
		vim.keymap.set("n", "<Leader>dBL", dap.list_breakpoints, {})
		vim.keymap.set("n", "<Leader>dpt", dap.pause, {})
		vim.keymap.set('n', '|', dap.step_over, {})
		vim.keymap.set('n', '<Leader>di', dap.step_into, {})
		vim.keymap.set('n', '<Leader>do', dap.step_out, {})

		dap.adapters.gdb = {
			type = "executable",
			command = "gdb",
			args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
		}

		dap.adapters.codelldb = {
			type = "executable",
			command = "codelldb",
		}

		dap.configurations.cpp = {
			{
				name = "Launch file",
				type = "codelldb",
				request = "launch",
				program = function()
					return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
				end,
				cwd = '${workspaceFolder}',
				stopOnEntry = true,
			},
		}

		dap.configurations.c = dap.configurations.cpp
		dap.configurations.zig = dap.configurations.cpp
	end,
}
