-- Treesitter (branch main): highlight + indentasi berbasis struktur kode.
-- Parser dikompilasi lokal, butuh `tree-sitter` CLI dan gcc.
local parsers = {
	"bash",
	"blade",
	"css",
	"diff",
	"dockerfile",
	"gitignore",
	"html",
	"http",
	"javascript",
	"jsdoc",
	"json",
	"lua",
	"luadoc",
	"markdown",
	"markdown_inline",
	"php",
	"php_only",
	"python",
	"query",
	"regex",
	"scss",
	"sql",
	"toml",
	"tsx",
	"typescript",
	"vim",
	"vimdoc",
	"yaml",
}

local indent_fts = {
	"lua",
	"javascript",
	"javascriptreact",
	"typescript",
	"typescriptreact",
	"css",
	"scss",
	"json",
	"jsonc",
	"php",
	"html",
}

return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").install(parsers)

			vim.treesitter.language.register("json", "jsonc")

			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("bagus_treesitter", { clear = true }),
				callback = function(ev)
					if not pcall(vim.treesitter.start, ev.buf) then
						return
					end
					if not vim.tbl_contains(indent_fts, ev.match) then
						return
					end
					-- Branch main nvim-treesitter belum tentu punya .indentexpr().
					-- Coba modul nvim-treesitter dulu (perilaku lama), lalu API bawaan Neovim.
					-- Bila keduanya tidak ada, biarkan indentexpr kosong (smartindent/autoindent tetap jalan).
					local ok, ts = pcall(require, "nvim-treesitter")
					if ok and type(ts.indentexpr) == "function" then
						vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					elseif type(vim.treesitter.indentexpr) == "function" then
						vim.bo[ev.buf].indentexpr = "v:lua.vim.treesitter.indentexpr()"
					end
				end,
			})
		end,
	},
}
