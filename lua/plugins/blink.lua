return {
	{
		"saghen/blink.cmp",
		version = "1.*",
		dependencies = {
			"rafamadriz/friendly-snippets",
		},

		opts = {
			keymap = {
				preset = "default",

				["<Tab>"] = {
					"select_and_accept",
					"snippet_forward",
					"fallback",
				},

				["<S-Tab>"] = {
					"select_prev",
					"snippet_backward",
					"fallback",
				},

				["<CR>"] = {
					"accept",
					"fallback",
				},
			},

			appearance = {
				nerd_font_variant = "mono",
			},

			completion = {
				documentation = {
					auto_show = false,
				},

				list = {
					selection = {
						preselect = false,
						auto_insert = false,
					},
				},
			},

			sources = {
				default = {
					"lsp",
					"path",
					"snippets",
					"buffer",
				},
			},

			snippets = {
				preset = "default",
			},

			fuzzy = {
				implementation = "prefer_rust_with_warning",
			},
		},
	},
}
