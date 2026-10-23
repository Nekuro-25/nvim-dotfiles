-- Markdown: tampilan terformat langsung di buffer (judul, kode, daftar, tabel)
return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = { "markdown" },
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
		keys = {
			{ "<leader>um", "<cmd>RenderMarkdown toggle<CR>", desc = "Toggle render Markdown" },
		},
		opts = {
			heading = { sign = false },
			code = { sign = false, width = "block" },
		},
	},
}
