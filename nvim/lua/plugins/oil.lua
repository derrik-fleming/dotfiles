return {
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>e", "<cmd>Oil<cr>", mode = "n", desc = "Open Filesystem" },
      { "<leader>-", "<cmd>Oil --float<cr>", mode = "n", desc = "Open Floating Filesystem" },
    },
    opts = {
      default_file_explorer = true,
      view_options = {
        show_hidden = true,
      },
      delete_to_trash = true,
      keymaps = {
        ["<Esc>"] = "actions.close",
      },
      win_options = {
        signcolumn = "yes:2",
      },
    },
  },
  {
    "refractalize/oil-git-status.nvim",

    dependencies = {
      "stevearc/oil.nvim",
    },

    config = true,
  },
}
