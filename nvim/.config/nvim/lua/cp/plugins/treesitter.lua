return {
    {
      "nvim-treesitter/nvim-treesitter",
      event = { "BufReadPre", "BufNewFile" },
      build = ":TSUpdate",
      dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
        "windwp/nvim-ts-autotag",
      },
      config = function()
        local treesitter = require("nvim-treesitter.configs")

        treesitter.setup({
          highlight = {
            enable = true,
          },
          indent = { enable = true },
          autotag = {
            enable = true,
          },
          ensure_installed = {
            "zig",
            "c",
            "cpp",
            "diff",

            "markdown",
            "markdown_inline",
            "bash",
            "lua",

            "json",

            "html",
            "css",

            "vim",
            "dockerfile",
            "gitignore",
          },
        })
      end,
    },
  }
