-- Leader key harus diset SEBELUM lazy.nvim dimuat
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local o = vim.opt

-- Tampilan dasar
o.number = true
o.relativenumber = true
o.cursorline = true
o.signcolumn = "yes"        -- kolom tanda (git/diagnostic) selalu ada, layar tidak "loncat"
o.termguicolors = true
o.wrap = false
o.scrolloff = 8
o.showmode = false          -- mode akan ditampilkan statusline di tahap berikutnya
o.winborder = "rounded"     -- jendela melayang (popup) berbingkai bulat
o.fillchars = { eob = " " } -- hilangkan tanda ~ di baris kosong

-- Indentasi (default 4 spasi; HTML/CSS/JS/Lua diubah jadi 2 di config/autocmds.lua)
o.tabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.smartindent = true

-- Pencarian
o.ignorecase = true
o.smartcase = true

-- Window
o.splitright = true
o.splitbelow = true

-- Lain-lain
o.undofile = true           -- undo tetap ada setelah file ditutup
o.updatetime = 250
o.timeoutlen = 400
o.mouse = "a"
o.clipboard = "unnamedplus" -- di Wayland butuh paket wl-clipboard
