-- Syntax highlighting yang lebih akurat.
-- Di Arch butuh paket: tree-sitter-cli dan compiler C (base-devel).
return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").install({
      "lua", "vim", "vimdoc", "bash",
      "python",
      "html", "css", "javascript", "json",
      "markdown", "markdown_inline",
    })

    -- Aktifkan highlight treesitter otomatis untuk filetype yang parser-nya tersedia
    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        pcall(vim.treesitter.start, args.buf)
      end,
    })
  end,
}
