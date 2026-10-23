-- LSP: server bahasa dipasang lewat Mason, dikonfigurasi lewat vim.lsp.config (Neovim 0.11+)
return {
	{
		"mason-org/mason.nvim",
		cmd = "Mason",
		build = ":MasonUpdate",
		opts = { ui = { border = "rounded" } },
	},

	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"mason-org/mason.nvim",
			"mason-org/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"saghen/blink.cmp",
		},
		config = function()
			local servers = {
				lua_ls = {
					settings = {
						Lua = {
							runtime = { version = "LuaJIT" },
							workspace = { checkThirdParty = false },
							completion = { callSnippet = "Replace" },
							format = { enable = false },
						},
					},
				},
				bashls = {},
				html = {},
				cssls = {},
				ts_ls = {},
				jsonls = {},
				emmet_language_server = {
					filetypes = {
						"html",
						"css",
						"scss",
						"less",
						"javascriptreact",
						"typescriptreact",
						"php",
						"blade",
					},
				},
				intelephense = {},
				marksman = {},
			}

			vim.diagnostic.config({
				severity_sort = true,
				update_in_insert = false,
				underline = true,
				virtual_text = { spacing = 2, prefix = "●" },
				float = { border = "rounded", source = true },
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "✘",
						[vim.diagnostic.severity.WARN] = "▲",
						[vim.diagnostic.severity.INFO] = "●",
						[vim.diagnostic.severity.HINT] = "◆",
					},
				},
			})

			-- Capabilities dari blink.cmp bila sudah dimuat, jika belum pakai default Neovim.
			-- Ini menghindari blink.cmp dimuat paksa saat startup (event-nya InsertEnter/CmdlineEnter).
			local function lsp_capabilities()
				local blink = package.loaded["blink.cmp"]
				if blink and type(blink.get_lsp_capabilities) == "function" then
					return blink.get_lsp_capabilities()
				end
				return vim.lsp.protocol.make_client_capabilities()
			end
			vim.lsp.config("*", { capabilities = lsp_capabilities() })

			for name, config in pairs(servers) do
				vim.lsp.config(name, config)
			end

			require("mason-lspconfig").setup({
				ensure_installed = vim.tbl_keys(servers),
				automatic_enable = true,
			})

			require("mason-tool-installer").setup({
				ensure_installed = { "php-cs-fixer", "shfmt", "shellcheck", "php-debug-adapter" },
				run_on_start = true,
				start_delay = 3000,
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("bagus_lsp", { clear = true }),
				callback = function(ev)
					local function map(mode, lhs, rhs, desc)
						vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, desc = desc })
					end
					local tb = function(name, opts)
						return function()
							require("telescope.builtin")[name](opts or {})
						end
					end
					map("n", "gd", tb("lsp_definitions", { reuse_win = true }), "Ke definisi")
					map("n", "gr", tb("lsp_references", { reuse_win = true }), "Referensi")
					map(
						"n",
						"gI",
						tb("lsp_implementations", { reuse_win = true }),
						"Ke implementasi"
					)
					map(
						"n",
						"gy",
						tb("lsp_type_definitions", { reuse_win = true }),
						"Ke definisi tipe"
					)
					map("n", "gD", vim.lsp.buf.declaration, "Ke deklarasi")
					map("n", "K", vim.lsp.buf.hover, "Dokumentasi (hover)")
					map("n", "gK", vim.lsp.buf.signature_help, "Bantuan signature")
					map({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
					map("n", "<leader>cr", vim.lsp.buf.rename, "Ganti nama simbol")
					map("n", "<leader>cs", tb("lsp_document_symbols"), "Simbol dokumen")
					map("n", "<leader>cS", tb("lsp_dynamic_workspace_symbols"), "Simbol workspace")
				end,
			})
		end,
	},
}
