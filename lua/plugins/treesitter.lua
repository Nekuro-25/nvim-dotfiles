return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",

		config = function()
			local parsers = {
				"lua",
				"vim",
				"vimdoc",
				"bash",
				"python",

				-- Web development
				"html",
				"css",
				"scss",
				"javascript",
				"typescript",
				"tsx",
				"json",
				"yaml",

				-- PHP
				"php",

				-- Dokumentasi dan konfigurasi
				"markdown",
				"markdown_inline",
			}

			require("nvim-treesitter").install(parsers)

			-- Aktifkan Treesitter pada buffer yang mendukung parser.
			local group = vim.api.nvim_create_augroup("user-treesitter", { clear = true })

			vim.api.nvim_create_autocmd("FileType", {
				group = group,
				callback = function(event)
					local ok = pcall(vim.treesitter.start, event.buf)

					if not ok then
						-- Parser mungkin belum terpasang atau filetype
						-- belum memiliki parser yang sesuai.
						return
					end
				end,
			})
		end,
	},
}
