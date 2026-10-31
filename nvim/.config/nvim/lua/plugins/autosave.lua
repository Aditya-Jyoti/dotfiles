return {
  "pocco81/auto-save.nvim",

  config = function()
    require("auto-save").setup({
      enabled = true,

      execution_message = {
        message = function()
          return ("AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"))
        end,
        dim = 0.18,
        cleaning_interval = 1250,
      },

      trigger_events = { "InsertLeave", "TextChanged" },

      debounce_delay = 135,

      condition = function(buf)
        local fn = vim.fn
        local utils = require("auto-save.utils.data")

        if
          fn.getbufvar(buf, "&modifiable") == 1 and
          utils.not_in(fn.getbufvar(buf, "&filetype"), {})
        then
          return true
        end

        return false
      end,
    })
  end,
}