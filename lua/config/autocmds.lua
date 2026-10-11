local augroup = vim.api.nvim_create_augroup("bagus_config", { clear = true })

-- Kedipkan teks yang baru di-copy (yank), supaya kelihatan apa yang tersalin
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup,
  callback = function()
    vim.hl.on_yank({ timeout = 150 })
  end,
})

-- HTML, CSS, JS, JSON, dan Lua lazimnya memakai indentasi 2 spasi
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = { "html", "css", "javascript", "json", "lua" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
})
