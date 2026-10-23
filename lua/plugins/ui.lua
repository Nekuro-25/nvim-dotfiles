-- Tampilan: statusline, bufferline, garis indent, which-key
return {
	{ "nvim-tree/nvim-web-devicons", lazy = true },

	-- Statusline (menampilkan mode karena showmode = false)
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = "VeryLazy",
		opts = function()
			local c = {
				none = "NONE", fg = "#dbe6ff", muted = "#9aabe0", dim = "#34447f", deep = "#0d1433",
				peri = "#8fa8f2", ice = "#a8c4ff", teal = "#74d6e0", pink = "#f2829c", yellow = "#e6c987",
			}
			local function mode(color)
				return {
					a = { fg = c.deep, bg = color, gui = "bold" },
					b = { fg = c.fg, bg = c.dim },
					c = { fg = c.muted, bg = c.none },
				}
			end
			local theme = {
				normal = mode(c.peri),
				insert = mode(c.ice),
				visual = mode(c.teal),
				replace = mode(c.pink),
				command = mode(c.yellow),
				inactive = {
					a = { fg = c.muted, bg = c.none },
					b = { fg = c.muted, bg = c.none },
					c = { fg = c.muted, bg = c.none },
				},
			}
			return {
				options = {
					theme = theme,
					globalstatus = true,
					component_separators = "",
					section_separators = "",
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff", "diagnostics" },
					lualine_c = { { "filename", path = 1 } },
					lualine_x = { "encoding", "filetype" },
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
			}
		end,
	},

	-- Tab buffer di atas
	{
		"akinsho/bufferline.nvim",
		version = "*",
		event = "VeryLazy",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = {
			{ "<leader>bp", "<cmd>BufferLineTogglePin<CR>", desc = "Pin buffer" },
			{ "<leader>bo", "<cmd>BufferLineCloseOthers<CR>", desc = "Tutup buffer lain" },
			{ "<leader>br", "<cmd>BufferLineCloseRight<CR>", desc = "Tutup buffer di kanan" },
			{ "<leader>bl", "<cmd>BufferLineCloseLeft<CR>", desc = "Tutup buffer di kiri" },
		},
		opts = function()
			local fg_dim, fg_sel, bg_sel, sep = "#8091cc", "#dbe6ff", "#1b2658", "#34447f"
			local function plain(fg) return { fg = fg, bg = "NONE" } end
			local function selected() return { fg = fg_sel, bg = bg_sel, bold = true, italic = false } end
			return {
				options = {
					mode = "buffers",
					diagnostics = "nvim_lsp",
					always_show_bufferline = false,
					separator_style = "thin",
					show_buffer_close_icons = false,
					show_close_icon = false,
				},
				highlights = {
					fill = { bg = "NONE" },
					background = plain(fg_dim),
					buffer_visible = plain(fg_dim),
					buffer_selected = selected(),
					separator = { fg = sep, bg = "NONE" },
					separator_visible = { fg = sep, bg = "NONE" },
					separator_selected = { fg = sep, bg = bg_sel },
					indicator_visible = plain(fg_dim),
					indicator_selected = { fg = "#a8c4ff", bg = bg_sel },
					modified = { fg = "#e6c987", bg = "NONE" },
					modified_visible = { fg = "#e6c987", bg = "NONE" },
					modified_selected = { fg = "#e6c987", bg = bg_sel },
					tab = plain(fg_dim),
					tab_selected = selected(),
					tab_separator = { fg = sep, bg = "NONE" },
					tab_separator_selected = { fg = sep, bg = bg_sel },
					close_button = plain(fg_dim),
					close_button_visible = plain(fg_dim),
					close_button_selected = { fg = fg_sel, bg = bg_sel },
					duplicate = plain(fg_dim),
					duplicate_visible = plain(fg_dim),
					duplicate_selected = { fg = fg_dim, bg = bg_sel },
				},
			}
		end,
	},

	-- Garis indent (tab ikut digambar)
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			indent = { char = "│", tab_char = "│" },
			scope = { enabled = true, show_start = false, show_end = false },
			exclude = {
				filetypes = { "help", "lazy", "mason", "trouble", "yazi", "notify", "checkhealth", "TelescopePrompt", "dapui_scopes", "dapui_breakpoints", "dapui_stacks", "dapui_watches", "dap-repl" },
			},
		},
	},

	-- Petunjuk keymap
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			preset = "modern",
			delay = 300,
			win = { border = "rounded" },
			spec = {
				{ "<leader>b", group = "buffer" },
				{ "<leader>c", group = "code" },
				{ "<leader>d", group = "debug" },
				{ "<leader>f", group = "cari (find)" },
				{ "<leader>g", group = "git" },
				{ "<leader>gh", group = "hunk" },
				{ "<leader>r", group = "REST client" },
				{ "<leader>s", group = "search" },
				{ "<leader>u", group = "toggle" },
				{ "<leader>x", group = "diagnostik / todo" },
			},
		},
	},
}
