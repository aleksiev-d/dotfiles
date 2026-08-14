-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set("n", "x", '"_x')
vim.keymap.set("n", "X", '"_X')
-- Resize windows with Alt+arrow keys
vim.keymap.set("n", "<A-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
vim.keymap.set("n", "<A-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
vim.keymap.set("n", "<A-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
vim.keymap.set("n", "<A-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

vim.keymap.set("n", "<leader>ga", function()
  require("gitsigns").blame()
end, { desc = "Blame Buffer" })
