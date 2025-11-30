vim.g.mapleader = " "

local km = vim.keymap

km.set("n", "<C-u>", "<C-u>zz", { desc = "Move Up Half Page" })
km.set("n", "<C-d>", "<C-d>zz", { desc = "Move Up Half Page" })

km.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })
km.set("n", "<leader>ft", ":tag <cword><CR>", { desc = "Follow tag under cursor" })

km.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

--NOTE: For rename (grn) and hover info (K) the defaults are used

km.set("n", "<leader>gd", "<cmd>Telescope lsp_definitions<CR>", opt)
km.set("n", "<leader>gr", "<cmd>Telescope lsp_references<CR>", opt)
km.set("n", "<leader>gt", "<cmd>Telescope lsp_type_definitions<CR>", opt)
km.set("n", "<leader>gi", "<cmd>Telescope lsp_implementations<CR>", opt)

km.set("n", "<leader>db", "<cmd>Telescope diagnostics bufnr=0<CR>", opt)
km.set("n", "<leader>dd", "<cmd>Telescope diagnostics", opt)
