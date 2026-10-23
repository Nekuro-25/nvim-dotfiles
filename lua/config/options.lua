-- Leader key harus diset SEBELUM lazy.nvim dimuat
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Format otomatis saat simpan. Matikan: <leader>uf (global) / <leader>uF (buffer ini)
vim.g.autoformat = true

local o = vim.opt

-- Tampilan
o.number = true
o.relativenumber = true
o.cursorline = true
o.signcolumn = "yes"        -- kolom tanda (git/diagnostik) selalu ada, layar tidak "loncat"
o.termguicolors = true
o.wrap = true
o.linebreak = true          -- pecah baris di batas kata
o.breakindent = true        -- baris lanjutan mengikuti indentasi
o.scrolloff = 8
o.sidescrolloff = 8
o.showmode = false          -- mode ditampilkan lualine
o.laststatus = 3            -- satu statusline global
o.winborder = "rounded"     -- jendela melayang berbingkai bulat
o.fillchars = { eob = " " } -- hilangkan tanda ~ di baris kosong
o.pumheight = 12
o.confirm = true            -- tanya dulu sebelum menutup buffer yang belum disimpan

-- Karakter tak terlihat. Tab ditampilkan kosong supaya garis indent (ibl) yang tampak.
o.list = true
o.listchars = { tab = "  ", trail = "·", nbsp = "␣" }

-- Indentasi: TAB, lebar tampilan 4. shiftwidth = 0 berarti ikut tabstop.
-- Pengecualian (YAML, Markdown, Python memakai spasi): lihat config/autocmds.lua
o.tabstop = 4
o.softtabstop = 0
o.shiftwidth = 0
o.expandtab = false
o.autoindent = true
o.smartindent = true

-- Pencarian
o.ignorecase = true
o.smartcase = true
o.inccommand = "split"
o.grepprg = "rg --vimgrep --smart-case"
o.grepformat = "%f:%l:%c:%m"

-- Window
o.splitright = true
o.splitbelow = true
o.splitkeep = "screen"

-- Lain-lain
o.undofile = true           -- undo tetap ada setelah file ditutup
o.updatetime = 250
o.timeoutlen = 400
o.mouse = "a"
o.clipboard = "unnamedplus" -- di Wayland butuh paket wl-clipboard
o.completeopt = { "menu", "menuone", "noselect" }
