return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      -- eslint = {},
      dartls = {
        setup = {
          cmd = { "dart", "language-server", "--protocol=lsp" },
        },
      },
      pyright = {},
      phpactor = {},
      stylelint_lsp = {},
      sourcekit = {
        cmd = { "sourcekit-lsp" },
      },
      -- vtsls = {
      --   enabled = false,
      -- },
      -- tailwindcss = {},
      -- tsserver = {
      --   enabled = true,
      --   settings = {
      --     typescript = {
      --       inlayHints = {
      --         includeInlayEnumMemberValueHints = true,
      --         includeInlayFunctionLikeReturnTypeHints = true,
      --         includeInlayFunctionParameterTypeHints = true,
      --         includeInlayParameterNameHints = "literals",
      --         includeInlayParameterNameHintsWhenArgumentMatchesName = false,
      --         includeInlayPropertyDeclarationTypeHints = true,
      --         includeInlayVariableTypeHints = false,
      --         includeInlayVariableTypeHintsWhenTypeMatchesName = false,
      --       },
      --     },
      --     completions = {
      --       completeFunctionCalls = true,
      --     },
      --   },
      -- },
    },
    -- setup = {
    --   eslint = function()
    --     require("lazyvim.util").lsp.on_attach(function(client)
    --       -- if client.name == "eslint" then
    --       --   client.server_capabilities.documentFormattingProvider = true
    --       if client.name == "tsserver" then
    --         client.server_capabilities.documentFormattingProvider = false
    --       elseif client.name == "ruff_lsp" then
    --         -- Disable hover in favor of Pyright
    --         client.server_capabilities.hoverProvider = false
    --       end
    --     end)
    --   end,
    -- },
  },
}
