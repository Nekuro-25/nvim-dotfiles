-- Urutan penting: options (leader key) -> keymaps -> autocmds -> plugin manager -> tema
require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.lazy")

pcall(vim.cmd.colorscheme, "indigo-night")

vim.opt.clipboard = "unnamedplus"

