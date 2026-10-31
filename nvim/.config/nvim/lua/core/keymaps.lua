local keymap = vim.keymap.set

-- leader key
vim.g.mapleader = " "

-- file explorer
-- keymap("n", "<leader>e", "<cmd>Yazi toggle<CR>")

-- save
keymap("n", "<leader>w", "<cmd>w<CR>")

-- quit
keymap("n", "<leader>q", "<cmd>q<CR>")

-- better window navigation
keymap("n", "<C-h>", "<C-w>h")
keymap("n", "<C-l>", "<C-w>l")
keymap("n", "<C-j>", "<C-w>j")
keymap("n", "<C-k>", "<C-w>k")


-- SNACKS UTILS

local Snacks = require("snacks")

------------------------------------------------
-- Toggle focus between explorer and editor
------------------------------------------------
vim.keymap.set("n", "<leader>e", function()
    Snacks.explorer.open()
end, { desc = "Toggle explorer focus" })

------------------------------------------------
-- Lazygit
------------------------------------------------
vim.keymap.set("n", "<leader>g", function()
  Snacks.lazygit()
end, { desc = "Lazygit" })

------------------------------------------------
-- Terminal
------------------------------------------------
vim.keymap.set("n", "<leader>t", function()
  Snacks.terminal.toggle()
end, { desc = "Toggle Terminal" })

------------------------------------------------
-- Pickers
------------------------------------------------
vim.keymap.set("n", "<leader>p", function()
  Snacks.picker.files()
end, { desc = "Find Files" })
