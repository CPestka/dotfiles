vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Move Up Half Page" })
keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Move Up Half Page" })

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

keymap.set("n", "<leader>ft", ":tag <cword><CR>", {desc = "Follow tag under cursor" })
keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
