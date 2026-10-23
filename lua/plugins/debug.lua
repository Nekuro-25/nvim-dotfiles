-- Debugger (DAP). Saat ini diatur untuk PHP lewat Xdebug.
-- Syarat di sisi PHP (sekali saja): paket `xdebug` dan di php.ini:
--     zend_extension=xdebug
--     xdebug.mode=debug
--     xdebug.start_with_request=yes
--     xdebug.client_port=9003
return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
		},
		keys = {
			{ "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Breakpoint" },
			{ "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Kondisi: ")) end, desc = "Breakpoint bersyarat" },
			{ "<leader>dc", function() require("dap").continue() end, desc = "Mulai / lanjut" },
			{ "<leader>di", function() require("dap").step_into() end, desc = "Step masuk" },
			{ "<leader>do", function() require("dap").step_over() end, desc = "Step lewat" },
			{ "<leader>dO", function() require("dap").step_out() end, desc = "Step keluar" },
			{ "<leader>dt", function() require("dap").terminate() end, desc = "Hentikan" },
			{ "<leader>dr", function() require("dap").repl.toggle() end, desc = "REPL" },
			{ "<leader>du", function() require("dapui").toggle() end, desc = "Panel debug (UI)" },
			{ "<leader>de", function() require("dapui").eval() end, mode = { "n", "v" }, desc = "Evaluasi" },
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			dapui.setup()

			-- Panel debug terbuka otomatis saat sesi mulai, tertutup saat selesai
			dap.listeners.before.attach.dapui_config = function() dapui.open() end
			dap.listeners.before.launch.dapui_config = function() dapui.open() end
			dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
			dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

			vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint" })
			vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DapBreakpoint" })
			vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DapStopped", linehl = "DapStoppedLine" })

			-- Adapter PHP dipasang Mason (php-debug-adapter)
			dap.adapters.php = {
				type = "executable",
				command = vim.fn.stdpath("data") .. "/mason/bin/php-debug-adapter",
			}
			dap.configurations.php = {
				{ type = "php", request = "launch", name = "Dengarkan Xdebug (port 9003)", port = 9003 },
			}
		end,
	},
}
