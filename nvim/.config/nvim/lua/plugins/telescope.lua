return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },

  opts = {
    defaults = {
      layout_strategy = "horizontal",

      layout_config = {
        prompt_position = "top",
        preview_cutoff = 1,
      },

      sorting_strategy = "ascending",
    },
  },
}