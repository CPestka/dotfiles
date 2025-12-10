return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-nvim-lsp"
	},
	config = function()
		local cmp = require("cmp")
		local cap = require('cmp_nvim_lsp').default_capabilities()

		cmp.setup({
			completion = {
				completeopt = "menu,menuone,preview,noselect",
			},
			mapping = cmp.mapping.preset.insert({
				["<C-n>"] = cmp.mapping.select_prev_item(),
				["<C-p>"] = cmp.mapping.select_next_item(),
				['<CR>'] = cmp.mapping.confirm { select = true },
				["<C-e>"] = cmp.mapping.abort(),
			}),

			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "path" },
			}),
		})

		vim.lsp.config("zls", {
			capabilities = cap
		})
		vim.lsp.config("clangd", {
			capabilities = cap
		})
		vim.lsp.config("luals", {
			capabilities = cap
		})
		vim.lsp.config("cmake", {
			capabilities = cap
		})
		vim.lsp.config("markdown_oxide", {
			capabilities = cap
		})
		vim.lsp.config("texlab", {
			capabilities = cap
		})
	end,
}
