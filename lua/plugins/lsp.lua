return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{
				"mason-org/mason.nvim",
				opts = {},
			},
			{
				"mason-org/mason-lspconfig.nvim",
				opts = {
					ensure_installed = {
						"html",
						"cssls",
						"ts_ls",
						"jsonls",
						"emmet_language_server",
						"phpactor",
						"lua_ls",
					},
					automatic_enable = true,
				},
			},
			"saghen/blink.cmp",
		},

		config = function()
			-- Integrasi capability LSP dengan Blink completion.
			vim.lsp.config("*", {
				capabilities = require("blink.cmp").get_lsp_capabilities(),
			})

			-- Konfigurasi khusus Lua agar memahami API Neovim.
			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							checkThirdParty = false,
							library = {
								vim.env.VIMRUNTIME,
							},
						},
					},
				},
			})

			-- Keymap hanya aktif pada buffer yang memiliki LSP.
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("user-lsp-keymaps", { clear = true }),
				callback = function(event)
					local opts = { buffer = event.buf }

					local function map(lhs, rhs, description)
						vim.keymap.set(
							"n",
							lhs,
							rhs,
							vim.tbl_extend("force", opts, {
								desc = description,
							})
						)
					end

					map("gd", vim.lsp.buf.definition, "LSP: Go to definition")
					map("gD", vim.lsp.buf.declaration, "LSP: Go to declaration")
					map("<leader>fr", vim.lsp.buf.references, "LSP: Find references")
					map("K", vim.lsp.buf.hover, "LSP: Hover documentation")
					map("<leader>ca", vim.lsp.buf.code_action, "LSP: Code action")
					map("<leader>rn", vim.lsp.buf.rename, "LSP: Rename symbol")
				end,
			})
		end,
	},
}
