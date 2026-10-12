return {
	{
		"nvim-telescope/telescope.nvim",
		version = "*",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
		},
		cmd = "Telescope",
		keys = {
			{
				"<leader>ff",
				"<cmd>Telescope find_files<CR>",
				desc = "Find files",
			},
			{
				"<leader>fg",
				"<cmd>Telescope live_grep<CR>",
				desc = "Search project text",
			},
			{
				"<leader>fb",
				"<cmd>Telescope buffers<CR>",
				desc = "Find open buffers",
			},
			{
				"<leader>fh",
				"<cmd>Telescope help_tags<CR>",
				desc = "Search help",
			},
		},
		opts = {
			defaults = {
				prompt_prefix = "  ",
				selection_caret = "  ",
				path_display = { "truncate" },
				sorting_strategy = "ascending",

				layout_config = {
					horizontal = {
						prompt_position = "top",
						preview_width = 0.55,
					},
					width = 0.90,
					height = 0.85,
				},

				file_ignore_patterns = {
					"%.git/",
					"node_modules/",
					"vendor/",
				},
			},

			pickers = {
				find_files = {
					hidden = true,
				},
			},
		},
	},
}
