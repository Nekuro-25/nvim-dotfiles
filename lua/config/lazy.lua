-- Bootstrap lazy.nvim (otomatis di-clone saat pertama kali nvim dibuka)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local out = vim.fn.system({
    "git", "clone", "--filter=blob:none", "--branch=stable",
    "https://github.com/folke/lazy.nvim.git", lazypath,
  })
  if vim.v.shell_error ~= 0 then
    error("Gagal clone lazy.nvim:\n" .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { import = "plugins" }, -- semua file di lua/plugins/*.lua dimuat otomatis
  },
  install = { colorscheme = { "indigo-night" } },
  checker = { enabled = false },           -- tidak cek update otomatis
  change_detection = { notify = false },
})
