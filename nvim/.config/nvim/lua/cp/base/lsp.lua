vim.lsp.config("zls", {
	cmd = { "zls" },
	filetypes = { "zig", "zir" },
	root_markers = { { "zls.json", "build.zig" }, ".git" },
	single_file_support = true,
})

vim.lsp.config("clangd", {
	cmd = { "clangd" },
	filetypes = { "c", "cpp", "h", "hpp", "cuda" },
	root_markers = { { ".clangd", ".clang-tidy", ".cland-format",
		"compile_commands.json",
		"compile_flags.txt", "configure.ac" },
		".git" },
	single_file_support = true,
})

vim.lsp.config("luals", {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
	settings = {
		Lua = {
			runtime = {
				version = 'LuaJIT',
			},
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		}
	}
})

vim.lsp.config("cmake", {
	cmd = { "cmake-language-server" },
	filetypes = { "cmake", "CMAKELISTS.txt" },
})

vim.lsp.config("markdown_oxide", {
	cmd = { "markdown-oxide" },
	filetypes = { "md" },
})

vim.lsp.config("texlab", {
	cmd = { "texlab" },
	filetypes = { "tex" },
})

vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(args)
		local km = vim.keymap
		local opt = { noremap = true, silent = true }
		local bfr = vim.lsp.buf

		km.set("n", "<leader>fb", bfr.format, opt)
	end,
})

vim.lsp.enable("zls")
vim.lsp.enable("clangd")
vim.lsp.enable("luals")
vim.lsp.enable("cmake")
vim.lsp.enable("markdown_oxide")
vim.lsp.enable("texlab")
