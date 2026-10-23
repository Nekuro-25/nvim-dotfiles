-- Penulisan kode: autocompletion (blink), format (conform), dukungan Lua untuk config ini
return {
	-- Autocompletion
	{
		"saghen/blink.cmp",
		version = "1.*", -- rilis stabil: biner pencocok (Rust) diunduh otomatis
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = { "rafamadriz/friendly-snippets" },
		opts = {
			-- Tab = terima saran / lompat di snippet; Shift+Tab = mundur
			-- Ctrl+n / Ctrl+p = pilih; Ctrl+Space = tampilkan; Ctrl+e = tutup
			keymap = { preset = "super-tab" },
			appearance = { nerd_font_variant = "normal" },
			completion = {
				accept = { auto_brackets = { enabled = true } },
				list = { selection = { preselect = true, auto_insert = false } },
				documentation = { auto_show = true, auto_show_delay_ms = 200 },
				ghost_text = { enabled = true },
			},
			signature = { enabled = true },
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
				per_filetype = {
					lua = { inherit_defaults = true, "lazydev" },
				},
				providers = {
					lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", score_offset = 100 },
				},
			},
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},

	-- Format kode (otomatis saat simpan; manual: <leader>cf)
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>cf",
				function() require("conform").format({ async = true, lsp_format = "fallback" }) end,
				mode = { "n", "v" },
				desc = "Format",
			},
		},
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettier" },
				javascriptreact = { "prettier" },
				typescript = { "prettier" },
				typescriptreact = { "prettier" },
				json = { "prettier" },
				jsonc = { "prettier" },
				css = { "prettier" },
				scss = { "prettier" },
				html = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				php = { "php_cs_fixer" },
				sh = { "shfmt" },
				bash = { "shfmt" },
			},
			format_on_save = function(bufnr)
				if vim.g.autoformat == false or vim.b[bufnr].autoformat == false then
					return
				end
				return { timeout_ms = 2000, lsp_format = "fallback" }
			end,
			formatters = {
				-- Prettier: pakai TAB (lebar 4) bila proyek tidak punya config sendiri
				-- ("prefer-file": file config proyek menang). YAML/Markdown tetap spasi.
				prettier = {
					prepend_args = function(_, ctx)
						local ft = vim.bo[ctx.buf].filetype
						if ft == "yaml" or ft == "markdown" then
							return {}
						end
						return { "--config-precedence", "prefer-file", "--use-tabs", "--tab-width", "4" }
					end,
				},
				-- PHP-CS-Fixer: PSR-12 dengan TAB. Config proyek (.php-cs-fixer.php) diutamakan;
				-- bila tidak ada, pakai ~/.config/nvim/php-cs-fixer.php
				php_cs_fixer = {
					args = function(_, ctx)
						local project = vim.fs.find(
							{ ".php-cs-fixer.php", ".php-cs-fixer.dist.php" },
							{ path = ctx.dirname, upward = true }
						)[1]
						local args = { "fix", "--using-cache=no" }
						if not project then
							table.insert(args, "--config=" .. vim.fn.stdpath("config") .. "/php-cs-fixer.php")
						end
						table.insert(args, "$FILENAME")
						return args
					end,
				},
			},
		},
	},

	-- Pelengkap API Neovim saat mengedit config Lua
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
}
