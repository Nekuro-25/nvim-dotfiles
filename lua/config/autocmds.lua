-- Deteksi filetype khusus (dijalankan sebelum plugin/filetype lain)
vim.filetype.add({
	extension = { http = "http", rest = "http" },
	pattern = { [".*%.blade%.php"] = "blade" },
})

local augroup = vim.api.nvim_create_augroup("bagus_config", { clear = true })

local function au(event, opts)
	opts.group = augroup
	vim.api.nvim_create_autocmd(event, opts)
end

-- Kedipkan teks yang baru di-copy (yank)
au("TextYankPost", {
	callback = function()
		vim.hl.on_yank({ timeout = 150 })
	end,
})

-- Semua bahasa memakai TAB. Beberapa ftplugin bawaan Neovim memaksa spasi (mis. SCSS),
-- jadi aturan tab diterapkan ulang setelah ftplugin. Pengecualian yang memang lazim/wajib
-- spasi ada di tabel ini (nilainya = lebar indentasi). Tambahkan bahasa lain di sini.
local space_filetypes = { yaml = 2, markdown = 2, python = 4 }

au("FileType", {
	callback = function(ev)
		if vim.bo[ev.buf].buftype ~= "" then
			return
		end
		local width = space_filetypes[ev.match]
		if width then
			vim.bo[ev.buf].expandtab = true
			vim.bo[ev.buf].tabstop = width
			vim.bo[ev.buf].shiftwidth = width
		else
			vim.bo[ev.buf].expandtab = false
			vim.bo[ev.buf].tabstop = 4
			vim.bo[ev.buf].shiftwidth = 0
			vim.bo[ev.buf].softtabstop = 0
		end
	end,
})

-- Kembalikan posisi kursor terakhir saat membuka file
au("BufReadPost", {
	callback = function(ev)
		local mark = vim.api.nvim_buf_get_mark(ev.buf, '"')
		local lines = vim.api.nvim_buf_line_count(ev.buf)
		if mark[1] > 0 and mark[1] <= lines then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- Samakan ukuran split saat jendela terminal berubah ukuran
au("VimResized", {
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})

-- Muat ulang file yang berubah di luar Neovim
au({ "FocusGained", "TermClose", "TermLeave" }, {
	command = "checktime",
})

-- Jendela bantu bisa ditutup dengan q
au("FileType", {
	pattern = { "help", "qf", "man", "checkhealth", "notify", "lspinfo", "startuptime", "query" },
	callback = function(ev)
		vim.bo[ev.buf].buflisted = false
		vim.keymap.set(
			"n",
			"q",
			"<cmd>close<CR>",
			{ buffer = ev.buf, silent = true, desc = "Tutup" }
		)
	end,
})

-- Klien REST mini untuk file .http / .rest (lihat config/rest.lua)
require("config.rest").setup()
