-- Penyuntingan: pencari (telescope), file manager (yazi), git, autopairs, diagnostik
return {
	-- Pencari file / teks
	{
		"nvim-telescope/telescope.nvim",
		branch = "master",
		cmd = "Telescope",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function() return vim.fn.executable("make") == 1 end,
			},
		},
		keys = {
			{ "<leader><space>", "<cmd>Telescope find_files<CR>", desc = "Cari file" },
			{ "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Cari file" },
			{ "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Cari teks (grep)" },
			{ "<leader>/", "<cmd>Telescope live_grep<CR>", desc = "Cari teks (grep)" },
			{ "<leader>fw", "<cmd>Telescope grep_string<CR>", desc = "Cari kata di kursor" },
			{ "<leader>fb", "<cmd>Telescope buffers sort_mru=true<CR>", desc = "Buffer" },
			{ "<leader>fr", "<cmd>Telescope oldfiles<CR>", desc = "File terakhir" },
			{ "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Bantuan" },
			{ "<leader>fk", "<cmd>Telescope keymaps<CR>", desc = "Keymap" },
			{ "<leader>fd", "<cmd>Telescope diagnostics<CR>", desc = "Diagnostik" },
			{ "<leader>fc", function() require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") }) end, desc = "File config Neovim" },
			{ "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "Git commit" },
			{ "<leader>gb", "<cmd>Telescope git_branches<CR>", desc = "Git branch" },
			{ "<leader>gt", "<cmd>Telescope git_status<CR>", desc = "Git status" },
		},
		opts = {
			defaults = {
				prompt_prefix = "   ",
				selection_caret = " ",
				path_display = { "truncate" },
				sorting_strategy = "ascending",
				layout_config = { prompt_position = "top", width = 0.9, height = 0.85 },
				file_ignore_patterns = { "node_modules/", "%.git/", "vendor/" },
			},
			pickers = {
				find_files = { hidden = true },
			},
		},
		config = function(_, opts)
			local telescope = require("telescope")
			telescope.setup(opts)
			pcall(telescope.load_extension, "fzf") -- sorter native (cepat)
		end,
	},

	-- File manager: Yazi di dalam Neovim
	{
		"mikavilpas/yazi.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "<leader>e", "<cmd>Yazi<CR>", desc = "Yazi (di file ini)" },
			{ "<leader>E", "<cmd>Yazi cwd<CR>", desc = "Yazi (folder kerja)" },
		},
		opts = {
			open_for_directories = true, -- `nvim folder/` membuka Yazi
			keymaps = { show_help = "<f1>" },
		},
		init = function()
			vim.g.loaded_netrwPlugin = 1 -- netrw tidak dipakai
		end,
	},

	-- Git: tanda perubahan di margin + aksi hunk
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "▁" },
				topdelete = { text = "▔" },
				changedelete = { text = "▎" },
				untracked = { text = "▎" },
			},
			on_attach = function(buffer)
				local gs = require("gitsigns")
				local function map(mode, lhs, rhs, desc)
					vim.keymap.set(mode, lhs, rhs, { buffer = buffer, desc = desc })
				end
				map("n", "]h", function()
					if vim.wo.diff then vim.cmd.normal({ "]c", bang = true }) else gs.nav_hunk("next") end
				end, "Hunk berikutnya")
				map("n", "[h", function()
					if vim.wo.diff then vim.cmd.normal({ "[c", bang = true }) else gs.nav_hunk("prev") end
				end, "Hunk sebelumnya")
				map("n", "<leader>ghs", gs.stage_hunk, "Stage hunk")
				map("n", "<leader>ghr", gs.reset_hunk, "Reset hunk")
				map("v", "<leader>ghs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Stage hunk")
				map("v", "<leader>ghr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Reset hunk")
				map("n", "<leader>ghS", gs.stage_buffer, "Stage seluruh buffer")
				map("n", "<leader>ghu", gs.undo_stage_hunk, "Batalkan stage hunk")
				map("n", "<leader>ghp", gs.preview_hunk_inline, "Pratinjau hunk")
				map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame baris ini")
				map("n", "<leader>ghd", gs.diffthis, "Diff terhadap index")
				map({ "o", "x" }, "ih", "<cmd>Gitsigns select_hunk<CR>", "Pilih hunk")
			end,
		},
	},

	-- Tanda kurung / kutip berpasangan
	{ "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },

	-- Tutup dan ganti nama tag HTML/JSX otomatis
	{ "windwp/nvim-ts-autotag", event = { "BufReadPre", "BufNewFile" }, opts = {} },

	-- Daftar diagnostik / referensi yang rapi
	{
		"folke/trouble.nvim",
		cmd = "Trouble",
		opts = {},
		keys = {
			{ "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", desc = "Diagnostik (semua)" },
			{ "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Diagnostik (buffer ini)" },
			{ "<leader>xs", "<cmd>Trouble symbols toggle focus=false<CR>", desc = "Simbol" },
			{ "<leader>xl", "<cmd>Trouble lsp toggle focus=false win.position=right<CR>", desc = "Definisi / referensi LSP" },
			{ "<leader>xq", "<cmd>Trouble qflist toggle<CR>", desc = "Quickfix" },
		},
	},

	-- Sorot dan cari TODO / FIXME / NOTE
	{
		"folke/todo-comments.nvim",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
		keys = {
			{ "]t", function() require("todo-comments").jump_next() end, desc = "TODO berikutnya" },
			{ "[t", function() require("todo-comments").jump_prev() end, desc = "TODO sebelumnya" },
			{ "<leader>xt", "<cmd>Trouble todo toggle<CR>", desc = "TODO (Trouble)" },
			{ "<leader>st", "<cmd>TodoTelescope<CR>", desc = "Cari TODO" },
		},
	},
}
