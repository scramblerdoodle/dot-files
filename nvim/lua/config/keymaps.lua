-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>fs", "<cmd>w<cr><esc>", { desc = "Save File" })
vim.keymap.set(
	"n",
	"<leader>zE",
	"<cmd>set spell spelllang=en_gb<cr><esc>",
	{ desc = "Set Text Language to English (GB)" }
)
vim.keymap.set(
	"n",
	"<leader>zU",
	"<cmd>set spell spelllang=en_us<cr><esc>",
	{ desc = "Set Text Language to English (US)" }
)
vim.keymap.set(
	"n",
	"<leader>zB",
	"<cmd>set spell spelllang=pt_br<cr><esc>",
	{ desc = "Set Text Language to Brazilian" }
)
