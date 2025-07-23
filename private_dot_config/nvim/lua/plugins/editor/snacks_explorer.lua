return {
  desc = "Snacks File Explorer",
  recommended = true,
  "folke/snacks.nvim",
  opts = {
    explorer = {
      enabled = false,
      replace_netrw = false,
    },
  },
  keys = {
    {
      "<leader>fe",
      false,
      --   function()
      --     Snacks.explorer({ cwd = LazyVim.root() })
      --   end,
      --   desc = "Explorer Snacks (root dir)",
    },
    {
      "<leader>fE",
      false,
      --   function()
      --     Snacks.explorer()
      --   end,
      --   desc = "Explorer Snacks (cwd)",
    },
    { "<leader>e", false },
    { "<leader>E", false },
  },
}
