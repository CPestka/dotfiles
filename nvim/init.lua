local opt = vim.opt
local km = vim.keymap.set
local global = vim.g
local pck = vim.pack
local cmd = vim.cmd
local lsp = vim.lsp

opt.number = true
opt.relativenumber = true
opt.wrap = false
opt.tabstop = 4
opt.swapfile = false
opt.expandtab = false
opt.autoindent = true
opt.cursorline = true
opt.colorcolumn = "80,120"
opt.scrolloff = 10
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
opt.winborder = "rounded"
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.spelllang = { 'en' }
opt.spell = true
opt.splitright = true
opt.list = true -- activate list mode i.e. show "suspicious formatting chars" e.g. trailing spaces, tabs, etc. etc.
opt.completeopt = "menuone,noselect,fuzzy,nosort"
opt.listchars = { trail = "*", tab = "<->" }

global.mapleader = " "

pck.add({
	{ src = "https://github.com/folke/tokyonight.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/stevearc/oil.nvim", },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons", },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/folke/todo-comments.nvim" },
	{ src = "https://github.com/hrsh7th/nvim-cmp" },
	{ src = "https://github.com/hrsh7th/cmp-buffer" },
	{ src = "https://github.com/hrsh7th/cmp-path" },
	{ src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	{ src = "https://github.com/numToStr/Comment.nvim" },
	{ src = "https://github.com/nvim-lua/plenary.nvim", },
	{ src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim", }, -- Currently kinda broken, one needs to go to the dir with this and call cmake manually (:echo &rtp -> somewhere there in pack dir)
	{ src = "https://github.com/nvim-telescope/telescope.nvim", },
})

require "Comment".setup()
require "gitsigns".setup()
require "lualine".setup({})
require "todo-comments".setup()
require "oil".setup({
	view_options = {
		show_hidden = true,
	}
})

local treesitter = require("nvim-treesitter")
treesitter.setup({
	highlight = { enable = true, },
	indent = { enable = true, },
})
treesitter.install(
	{
		"zig",
		"c",
		"cpp",
		"cuda",
		"fortran",
		"glsl",
		"hlsl",
		"nasm",
		"asm",
		"objdump",
		"xml",
		"yaml",
		"sql",
		"lua",
		"latex",
		"llvm",
		"html",
		"http",
		"gnuplot",
		"make",
		"cmake",
		"markdown",
		"bash",
		"awk",
		"bibtex",
		"csv",
		"diff",
		"dockerfile",
		"gitignore",
	}
)

local telescope = require("telescope")
local actions = require("telescope.actions")
telescope.setup(
	{
		defaults = {
			path_display = { "truncate " },
			mappings = {
				i = {
					["<Up>"] = actions.move_selection_previous,
					["<Down>"] = actions.move_selection_next,
				}
			}
		}
	}
)
telescope.load_extension("fzf")

local cmp = require("cmp")
local req_cap = require("cmp_nvim_lsp").default_capabilities()

cmp.setup(
	{
		completion = {
			completeopt = "menu,menuone,preview,noselect",
		},
		mapping = {
			["<Up>"] = cmp.mapping.select_prev_item(),
			["<Down>"] = cmp.mapping.select_next_item(),
			["<CR>"] = cmp.mapping.confirm { select = true },
			["<C-e>"] = cmp.mapping.abort(),
		},
		sources = cmp.config.sources(
			{
				{ name = "nvim_lsp" },
				{ name = "path" },
				{ name = "buffer" },
			}
		),
	}
)

lsp.config("zls", req_cap)
lsp.config("clangd", req_cap)
lsp.config("lua_ls", req_cap)
lsp.config("asm_lsp", req_cap)
lsp.config("sqls", req_cap)
lsp.config("bashls", req_cap)
lsp.config("cmake-language-server", req_cap)
lsp.config("markdown_oxide", req_cap)
lsp.config("texlab", req_cap)

-- The other lsp configs use only the defaults provided from nvim-lspconfig except the lsp capability override
lsp.config(
	"lua_ls", {
		settings = {
			Lua = {
				workspace = {
					library = vim.api.nvim_get_runtime_file("", true),
				}
			}
		}
	}
)

lsp.enable(
	{
		"zls",
		"clangd",
		"lua_ls",
		"asm_lsp",
		"sqls",
		"bashls",
		"cmake-language-server",
		"markdown_oxide",
		"texlab"
	}
)

cmd("colorscheme tokyonight")

--NOTE: For rename (grn) and hover info (K) the defaults are used
local telescope_op = require("telescope.builtin")
km("n", "<leader>ff", telescope_op.find_files, { desc = "Fuzzy Find Files in cwd" })
km("n", "<leader>fs", telescope_op.live_grep, { desc = "Find String in cwd" })
km("n", "<leader>f*", telescope_op.grep_string, { desc = "Find String under cursor in cwd" })
km("n", "<leader><leader>", telescope_op.buffers, { desc = "Find existing buffers" })
km("n", "<C-u>", "<C-u>zz", { desc = "Move Up Half Page" })
km("n", "<C-d>", "<C-d>zz", { desc = "Move Down Half Page" })
km("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })
km("n", "<leader>ft", ":tag <cword><CR>", { desc = "Follow tag under cursor" })
km("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
km("n", "<leader>fb", lsp.buf.format)
km("n", "<leader>gd", "<cmd>Telescope lsp_definitions<CR>")
km("n", "<leader>gr", "<cmd>Telescope lsp_references<CR>")
km("n", "<leader>gt", "<cmd>Telescope lsp_type_definitions<CR>")
km("n", "<leader>gi", "<cmd>Telescope lsp_implementations<CR>")
km("n", "<leader>db", "<cmd>Telescope diagnostics bufnr=0<CR>")
km("n", "<leader>dd", "<cmd>Telescope diagnostics<CR>")
