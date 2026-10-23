local map = vim.keymap.set

-- Hilangkan highlight hasil pencarian
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Hapus highlight cari" })

-- Simpan / keluar
map({ "n", "i", "x", "s" }, "<C-s>", "<cmd>w<CR><Esc>", { desc = "Simpan file" })
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Simpan file" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Keluar" })
map("n", "<leader>Q", "<cmd>qa<CR>", { desc = "Keluar semua" })

-- Pindah antar window
map("n", "<C-h>", "<C-w>h", { desc = "Window kiri" })
map("n", "<C-j>", "<C-w>j", { desc = "Window bawah" })
map("n", "<C-k>", "<C-w>k", { desc = "Window atas" })
map("n", "<C-l>", "<C-w>l", { desc = "Window kanan" })

-- Ubah ukuran window
map("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Window lebih tinggi" })
map("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Window lebih pendek" })
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Window lebih sempit" })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Window lebih lebar" })

-- Bagi window (tutup window: Ctrl+w lalu c)
map("n", "<leader>-", "<C-w>s", { desc = "Split ke bawah" })
map("n", "<leader>|", "<C-w>v", { desc = "Split ke kanan" })

-- Pindah antar buffer (file yang terbuka)
map("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Buffer berikutnya" })
map("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Buffer sebelumnya" })
map("n", "<leader>bb", "<cmd>e #<CR>", { desc = "Buffer sebelumnya (bolak-balik)" })
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Tutup buffer" })

-- Indentasi di visual mode tanpa kehilangan seleksi
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Geser baris terpilih naik/turun
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Geser baris ke bawah" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Geser baris ke atas" })

-- Diagnostik
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Diagnostik baris ini" })

-- Plugin
map("n", "<leader>l", "<cmd>Lazy<CR>", { desc = "Lazy (plugin)" })
map("n", "<leader>cm", "<cmd>Mason<CR>", { desc = "Mason (LSP, formatter)" })

-- Toggle
map("n", "<leader>uf", function()
	vim.g.autoformat = not vim.g.autoformat
	vim.notify("Format otomatis (global): " .. (vim.g.autoformat and "AKTIF" or "mati"))
end, { desc = "Toggle format otomatis (global)" })

map("n", "<leader>uF", function()
	vim.b.autoformat = vim.b.autoformat == false
	vim.notify("Format otomatis (buffer ini): " .. (vim.b.autoformat and "AKTIF" or "mati"))
end, { desc = "Toggle format otomatis (buffer ini)" })

map("n", "<leader>uw", function()
	vim.wo.wrap = not vim.wo.wrap
end, { desc = "Toggle wrap" })

map("n", "<leader>ud", function()
	vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "Toggle diagnostik" })

map("n", "<leader>uh", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }), { bufnr = 0 })
end, { desc = "Toggle inlay hints" })

map("n", "<leader>ui", "<cmd>Inspect<CR>", { desc = "Inspect highlight di kursor" })
