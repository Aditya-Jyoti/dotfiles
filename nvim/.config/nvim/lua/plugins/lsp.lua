return {
  {
    "neovim/nvim-lspconfig",
    config = function()

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Lua
      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
      })

      -- Go
      vim.lsp.config("gopls", {
        capabilities = capabilities,
      })

      -- Python
      vim.lsp.config("pyright", {
        capabilities = capabilities,
      })

      -- Typescript
      vim.lsp.config("ts_ls", {
        capabilities = capabilities,
      })

      -- Enable servers
      vim.lsp.enable({
        "lua_ls",
        "gopls",
        "pyright",
        "ts_ls",
      })

    end,
  },
}