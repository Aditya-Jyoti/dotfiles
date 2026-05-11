return {
  "smoka7/hop.nvim",
  version = "*",

  opts = {
    keys = "etovxqpdygfblzhckisuran",
  },

  keys = {
    {
      "f",
      function()
        require("hop").hint_char1()
      end,
      desc = "Hop to char (both directions)",
    },
  },
}