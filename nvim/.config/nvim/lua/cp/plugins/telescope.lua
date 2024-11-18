return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      telescope.setup({
        defaults = {
          path_display = { "truncate " },
          mappings = {
            i = {
              ["<C-k>"] = actions.move_selection_previous, -- move to prev result
              ["<C-j>"] = actions.move_selection_next, -- move to next result
            },
          },
        },
      })

      telescope.load_extension("fzf")

      local keymap = vim.keymap
      local builtin = require 'telescope.builtin'
      keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Fuzzy find files in cwd" })
      keymap.set("n", "<leader>fs", builtin.live_grep, { desc = "Find string in cwd" })
      keymap.set("n", "<leader>f*", builtin.grep_string, { desc = "Find string under cursor in cwd" })
      keymap.set('n', '<leader><leader>', builtin.buffers, { desc = 'Find existing buffers' })
      keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Find Help' })
    end,
  }
