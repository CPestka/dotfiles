function FormatFunction()
    vim.lsp.buf.format({
        async = true,
    })
end

return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        { "antosha417/nvim-lsp-file-operations", config = true },
    },
    config = function()
        local lspconfig = require("lspconfig")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        local keymap = vim.keymap
        local opts = { noremap = true, silent = true }
        local on_attach = function(client, bufnr)
            opts.buffer = bufnr

            opts.desc = "Show LSP references"
            keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)
            opts.desc = "Go to declaration"
            keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
            opts.desc = "Show LSP definitions"
            keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
            opts.desc = "Show LSP implementations"
            keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
            opts.desc = "Show LSP type definitions"
            keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

            opts.desc = "Format Buffer synchronously"
            keymap.set("n", "<leader>fb", "<Esc><cmd>lua FormatFunction()<CR>", opts)

            opts.desc = "Smart rename"
            keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

            opts.desc = "Show buffer diagnostics"
            keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)
            opts.desc = "Show line diagnostics"
            keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

            opts.desc = "Show documentation for what is under cursor"
            keymap.set("n", "K", vim.lsp.buf.hover, opts)
        end

        local capabilities = cmp_nvim_lsp.default_capabilities()

        lspconfig.zls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            cmd = { "zls" },
            filetypes = { "zig", "zir" },
            root_dir = lspconfig.util.root_pattern("zls.json", "build.zig", ".git"),
            single_file_support = true,
        })

        lspconfig.clangd.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            cmd = { "clangd" },
            filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
            root_dir = lspconfig.util.root_pattern(".clangd", ".clang-tidy", ".cland-format", "compile_commands.json",
                "compile_flags.txt", "configure.ac", ".git"),
            single_file_support = true,
        })

        lspconfig["lua_ls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
                Lua = {
                    -- make the language server recognize "vim" global
                    diagnostics = {
                        globals = { "vim" },
                    },
                    workspace = {
                        -- make language server aware of runtime files
                        library = {
                            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                            [vim.fn.stdpath("config") .. "/lua"] = true,
                        },
                    },
                },
            },
        })

        lspconfig["cmake"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            cmd = { "cmake-language-server" },
            filetypes = { "cmake", "CMAKELISTS.txt" },
        })

        lspconfig["markdown_oxide"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            cmd = { "markdown-oxide" },
            filetypes = { "md" },
        })

        lspconfig["texlab"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            cmd = { "texlab" },
            filetypes = { "tex" },
        })
    end,
}
