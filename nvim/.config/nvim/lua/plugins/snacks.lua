return {
  "folke/snacks.nvim",
  priority = 900,
  lazy = false,

  ---@type snacks.Config
  opts = {

    --------------------------------
    -- Explorer
    --------------------------------
    explorer = {
      replace_netrw = true,
      trash = true,
    },

    picker = {
      sources = {
        explorer = {},
      },
    },

    --------------------------------
    -- Indent guides
    --------------------------------
    indent = {
      enabled = true,
    },

    --------------------------------
    -- Better input UI
    --------------------------------
    input = {
      icon = " ",
      icon_pos = "left",
      prompt_pos = "title",
      expand = true,
      win = { style = "input" },
    },

    --------------------------------
    -- Lazygit
    --------------------------------
    lazygit = {
      configure = true,
      config = {
        os = { editPreset = "nvim-remote" },
        gui = { nerdFontsVersion = "3" },
      },
      win = { style = "lazygit" },
    },

    --------------------------------
    -- Terminal
    --------------------------------
    terminal = {
      win = { style = "terminal" },
    },
  },
}