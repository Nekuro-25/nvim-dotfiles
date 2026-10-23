-- =========================================================
-- NEOVIM — ICE BLUE NIGHT
-- Urutan penting: options (leader key) -> keymaps -> autocmds
--                 -> plugin manager -> tema
-- =========================================================
require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.lazy")

local ok, err = pcall(vim.cmd.colorscheme, "ice-night")
if not ok then
	vim.notify("Colorscheme ice-night gagal dimuat:\n" .. tostring(err), vim.log.levels.WARN)
end
