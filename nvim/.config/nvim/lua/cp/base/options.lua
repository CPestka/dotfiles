local opt = vim.opt

opt.relativenumber = true
opt.number = true -- shows absolute line number
opt.wrap = false
opt.cursorline = true
opt.colorcolumn = "80,120"

opt.tabstop = 4 -- 4 spaces for tabs
opt.shiftwidth = 4 -- 4 spaces for indent width
opt.expandtab = false -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

opt.scrolloff = 20

opt.ignorecase = true
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

opt.clipboard:append("unnamedplus") -- use system clipboard as default register

opt.splitright = true -- split vertical window to the right

opt.swapfile = false

opt.spelllang = { 'en' }
opt.spell = true
