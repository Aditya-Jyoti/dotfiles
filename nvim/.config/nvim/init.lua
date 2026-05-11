require("core.options")
require("core.lazy")
require("core.keymaps")

--------------------------------------------------
-- Matugen colorscheme loader
--------------------------------------------------
local function source_matugen()
  local matugen_path = vim.fn.expand("~/.cache/matugen/generated.lua")

  -- Always load gruvbox first for syntax colors
  vim.cmd("colorscheme gruvbox")  -- or "base16-gruvbox-dark" if you use base16

  if vim.fn.filereadable(matugen_path) == 1 then
    local ok, _ = pcall(dofile, matugen_path)
    if not ok then
      -- gruvbox already loaded above, nothing else needed
    end
  end
end

-- Load once on startup
source_matugen()

--------------------------------------------------
-- Reload on Matugen updates (SIGUSR1)
--------------------------------------------------
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

-- --------------------------------------------------
-- -- Open explorer on enter
-- --------------------------------------------------

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argv()[1] == nil then
      require("snacks").explorer.open()
    end
  end,
})
