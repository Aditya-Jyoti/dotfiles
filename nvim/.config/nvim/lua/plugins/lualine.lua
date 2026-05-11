return {
  "nvim-lualine/lualine.nvim",

  config = function()
    local status_ok, lualine = pcall(require, "lualine")
    if not status_ok then
      return
    end

    local diagnostics = {
      "diagnostics",
      sources = { "nvim_diagnostic" },
      sections = { "error", "warn", "hint" },
      symbols = { error = " ", warn = " ", hint = " " },
      colored = true,
      update_in_insert = false,
      always_visible = true,
    }

    local mode = {
      "mode",
      fmt = function(str)
        if str == "V-LINE" then
          return "X"
        end
        return string.sub(str, 1, 1)
      end,
    }

    local filename = function()
      return vim.fn.expand("%:t")
    end

    local filetype = {
      "filetype",
      icons_enabled = true,
    }

    local function selectionCount()
      local isVisualMode = vim.fn.mode():find("[Vv]")
      if not isVisualMode then
        return ""
      end
      local starts = vim.fn.line("v")
      local ends = vim.fn.line(".")
      local lines = starts <= ends and ends - starts + 1 or starts - ends + 1
      return tostring(lines) .. "L " .. tostring(vim.fn.wordcount().visual_chars) .. "C"
    end

    local function harpooned()
      local tabela = require("harpoon").get_mark_config()["marks"]
      local currentFile = vim.fn.split(vim.api.nvim_buf_get_name(0), "/")
      currentFile = currentFile[#currentFile]
      for _, value in pairs(tabela) do
        local file = vim.fn.split(value["filename"], "/")
        file = file[#file]
        if file == currentFile then
          return "󰃀"
        end
      end
      return "󰃃"
    end

    lualine.setup({
      options = {
        icons_enabled = true,
        theme = "gruvbox",
        globalstatus = true, 
        component_separators = "",
        section_separators = { left = "", right = "" },
        always_divide_middle = true,
        disabled_filetypes = {
          statusline = {
            "neo-tree",
            "neo-tree-popup",
            "neo-tree-preview",
          },
        },
      },
      sections = {
        lualine_a = { mode, selectionCount },
        lualine_b = { diagnostics },
        lualine_c = { "branch", "diff" },
        lualine_x = {},
        lualine_y = { filetype },
        lualine_z = { filename, harpooned },
      },
    })
  end,
}
