-- =========================================================
-- NEOVIM — ICE BLUE NIGHT
-- Urutan penting: options (leader key) -> keymaps -> autocmds
--                 -> perintah proyek -> plugin manager -> tema
-- =========================================================
require("config.options")
require("config.keymaps")
require("config.autocmds")

-- :NewPage dibuat di sini (murah). Modul learn-jp baru dimuat saat dipanggil.
vim.api.nvim_create_user_command("NewPage", function(opts)
	require("config.learn-jp").new_page(opts.args)
end, { nargs = "?", complete = "file", desc = "Halaman PHP baru (template learn-jp)" })

require("config.lazy")

local ok, err = pcall(vim.cmd.colorscheme, "ice-night")
if not ok then
	vim.notify("Colorscheme ice-night gagal dimuat:\n" .. tostring(err), vim.log.levels.WARN)
end
