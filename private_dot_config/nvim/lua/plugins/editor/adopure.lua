return {
  "Willem-J-an/adopure.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    vim.g.adopure = {}
  end,
  keys = {
    { "<leader>gp", group = "pull requests" },
    { "<leader>gpl", "<cmd>AdoPure load context<cr>", desc = "Load PR Context" },
    { "<leader>gpt", "<cmd>AdoPure load threads<cr>", desc = "Load Comment Threads" },
    { "<leader>gpn", "<cmd>AdoPure open new_thread<cr>", desc = "New Comment Thread" },
    { "<leader>gpc", "<cmd>AdoPure submit comment<cr>", desc = "Submit Comment" },
    { "<leader>gpv", "<cmd>AdoPure submit vote<cr>", desc = "Submit Vote" },
  },
}