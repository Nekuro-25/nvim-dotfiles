return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>f",
        function()
          require("conform").format({
            async = true,
            lsp_format = "fallback",
          })
        end,
        mode = "",
        desc = "Format code",
      },
    },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },

        html = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },

        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },

        json = { "prettier" },
        jsonc = { "prettier" },
        markdown = { "prettier" },
        yaml = { "prettier" },

        php = { "php_cs_fixer", lsp_format = "fallback" },
      },

      format_on_save = {
        timeout_ms = 1000,
        lsp_format = "fallback",
      },
    },
  },
}
