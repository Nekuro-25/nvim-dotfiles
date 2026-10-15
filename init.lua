-- Urutan penting: options (leader key) -> keymaps -> autocmds -> plugin manager -> tema
require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.lazy")

pcall(vim.cmd.colorscheme, "ice-night")

vim.opt.linebreak = true     -- Wrap at word boundaries instead of characters
vim.opt.breakindent = true   -- Keep indentation level on wrapped lines

