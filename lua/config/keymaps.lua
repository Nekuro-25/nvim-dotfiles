local map = vim.keymap.set

-- Hilangkan highlight hasil pencarian
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Hapus highlight cari" })

-- Simpan / keluar
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Simpan file" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Keluar" })

-- Pindah antar window
map("n", "<C-h>", "<C-w>h", { desc = "Window kiri" })
map("n", "<C-j>", "<C-w>j", { desc = "Window bawah" })
map("n", "<C-k>", "<C-w>k", { desc = "Window atas" })
map("n", "<C-l>", "<C-w>l", { desc = "Window kanan" })

-- Pindah antar buffer (file yang terbuka)
map("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Buffer berikutnya" })
map("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Buffer sebelumnya" })
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Tutup buffer" })

-- Indentasi di visual mode tanpa kehilangan seleksi
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Geser baris terpilih naik/turun
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Geser baris ke bawah" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Geser baris ke atas" })
