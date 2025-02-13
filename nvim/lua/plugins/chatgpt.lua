return {
  -- {
  --   "jackMort/ChatGPT.nvim",
  --   event = "VeryLazy",
  --   config = function()
  --     require("chatgpt").setup({
  --       api_key_cmd = "op read --account my.1password.com op://private/openai-api-key/credential",
  --       openai_params = {
  --         model = "gpt-4-turbo-preview",
  --         max_tokens = 1024,
  --       },
  --     })
  --   end,
  --   dependencies = {
  --     "MunifTanjim/nui.nvim",
  --     "nvim-lua/plenary.nvim",
  --     "folke/trouble.nvim",
  --     "nvim-telescope/telescope.nvim",
  --   },
  --   keys = {
  --     { "<leader>C", "", desc = "ChatGPT" },
  --     { "<leader>Cc", "<cmd>ChatGPT<CR>", "ChatGPT" },
  --     { "<leader>Ce", "<cmd>ChatGPTEditWithInstruction<CR>", "Edit with instruction", mode = { "n", "v" } },
  --     { "<leader>Cg", "<cmd>ChatGPTRun grammar_correction<CR>", "Grammar Correction", mode = { "n", "v" } },
  --     { "<leader>Ct", "<cmd>ChatGPTRun translate<CR>", "Translate", mode = { "n", "v" } },
  --     { "<leader>Ck", "<cmd>ChatGPTRun keywords<CR>", "Keywords", mode = { "n", "v" } },
  --     { "<leader>Cd", "<cmd>ChatGPTRun docstring<CR>", "Docstring", mode = { "n", "v" } },
  --     { "<leader>Ca", "<cmd>ChatGPTRun add_tests<CR>", "Add Tests", mode = { "n", "v" } },
  --     { "<leader>Co", "<cmd>ChatGPTRun optimize_code<CR>", "Optimize Code", mode = { "n", "v" } },
  --     { "<leader>Cs", "<cmd>ChatGPTRun summarize<CR>", "Summarize", mode = { "n", "v" } },
  --     { "<leader>Cf", "<cmd>ChatGPTRun fix_bugs<CR>", "Fix Bugs", mode = { "n", "v" } },
  --     { "<leader>Cx", "<cmd>ChatGPTRun explain_code<CR>", "Explain Code", mode = { "n", "v" } },
  --     { "<leader>Cr", "<cmd>ChatGPTRun roxygen_edit<CR>", "Roxygen Edit", mode = { "n", "v" } },
  --     {
  --       "<leader>Cl",
  --       "<cmd>ChatGPTRun code_readability_analysis<CR>",
  --       "Code Readability Analysis",
  --       mode = { "n", "v" },
  --     },
  --   },
  -- },
}
