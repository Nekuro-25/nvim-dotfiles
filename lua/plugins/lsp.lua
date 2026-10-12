return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "mason-org/mason.nvim",
        opts = {},
      },
      {
        "mason-org/mason-lspconfig.nvim",
        opts = {
          ensure_installed = {
            "html",
            "cssls",
            "ts_ls",
            "jsonls",
            "emmet_language_server",
            "phpactor",
            "lua_ls",
          },
          automatic_enable = true,
        },
      },
    },
    config = function()
      -- Konfigurasi khusus Lua agar memahami API Neovim.
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME,
              },
            },
          },
        },
      })

      -- Keymap LSP hanya aktif pada buffer yang memiliki LSP.
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(event)
          local opts = { buffer = event.buf }

          vim.keymap.set("n", "gd", vim.lsp.buf.definition,
            vim.tbl_extend("force", opts, {
              desc = "LSP: Go to definition",
            }))

          vim.keymap.set("n", "gD", vim.lsp.buf.declaration,
            vim.tbl_extend("force", opts, {
              desc = "LSP: Go to declaration",
            }))

          vim.keymap.set("n", "gr", vim.lsp.buf.references,
            vim.tbl_extend("force", opts, {
              desc = "LSP: Find references",
            }))

          vim.keymap.set("n", "K", vim.lsp.buf.hover,
            vim.tbl_extend("force", opts, {
              desc = "LSP: Hover documentation",
            }))

          vim.keymap.set("n", "<leader>ca",
            vim.lsp.buf.code_action,
            vim.tbl_extend("force", opts, {
              desc = "LSP: Code action",
            }))

          vim.keymap.set("n", "<leader>rn",
            vim.lsp.buf.rename,
            vim.tbl_extend("force", opts, {
              desc = "LSP: Rename symbol",
            }))
        end,
      })
    end,
  },
}
