return {
  "akinsho/bufferline.nvim",
  version = "*",

  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },

  opts = {
    options = {
      mode = "buffers",

      separator_style = "thin",

      diagnostics = "nvim_lsp",

      offsets = {
        {
          filetype = "neo-tree",
          text = "",
          highlight = "Directory",
          text_align = "left",
        },
      },

      show_buffer_close_icons = false,
      show_close_icon = false,
    },
  },
}