require("core.options")
require("core.lazy")

--------------------------------------------------
-- Matugen colorscheme loader
--------------------------------------------------

local function source_matugen()
  local matugen_path = vim.fn.expand("~/.cache/matugen/generated.lua")

  local ok, err = pcall(dofile, matugen_path)
  if not ok then
    -- Fallback colorscheme if Matugen hasn’t run yet
    vim.cmd("colorscheme base16-gruvbox-dark")
  end
end

-- Load once on startup
source_matugen()

-- --------------------------------------------------
-- -- Reload on Matugen updates (SIGUSR1)
-- --------------------------------------------------

vim.api.nvim_create_autocmd("Signal", {
  pattern = "SIGUSR1",
  callback = function()
    source_matugen()

    -- Reload lualine because base16 overrides highlights
    pcall(function()
      require("lualine").setup({
        options = { theme = "base16" },
      })
    end)

    -- Optional stylistic tweaks
    vim.api.nvim_set_hl(0, "Comment", { italic = true })
  end,
})

-- --------------------------------------------------
-- -- Fix lualine inverted colors (keep this)
-- --------------------------------------------------

vim.api.nvim_set_hl(0, "StatusLine", { reverse = false })
vim.api.nvim_set_hl(0, "StatusLineNC", { reverse = false })

-- --------------------------------------------------
-- -- Alacritty integration (unchanged)
-- --------------------------------------------------

local alacrittyAutoGroup = vim.api.nvim_create_augroup("alacritty", { clear = true })

vim.api.nvim_create_autocmd("VimEnter", {
  group = alacrittyAutoGroup,
  callback = function()
    vim.fn.jobstart(
      "alacritty msg --socket $ALACRITTY_SOCKET config -w $ALACRITTY_WINDOW_ID options 'window.padding.x=0' 'window.padding.y=0' 'window.dynamic_padding=false' &",
      { detach = true }
    )
  end,
})

vim.api.nvim_create_autocmd("VimLeavePre", {
  group = alacrittyAutoGroup,
  callback = function()
    vim.fn.jobstart(
      "alacritty msg --socket $ALACRITTY_SOCKET config -w $ALACRITTY_WINDOW_ID -r &",
      { detach = true }
    )
  end,
})
