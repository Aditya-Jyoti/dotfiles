return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup({
        ensure_installed = {
          "lua",
          "go",
          "python",
          "typescript",
          "javascript",
          "bash",
          "json",
          "markdown",
        },
        auto_install = false,
        sync_install = false,
        highlight = { enable = true },
      })
    end,
  },
}
