return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        html = {},
        cssls = {},
        jsonls = {},
        volar = {},
        stylelint_lsp = {},
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        css = { "prettierd" },
        html = { "prettierd" },
        json = { "prettierd" },
        jsonc = { "prettierd" },
        less = { "prettierd" },
        scss = { "prettierd" },
        vue = { "prettierd" },
        markdown = { "prettierd" },
        yaml = { "prettierd" },
        xml = { "xmlformat" },
        graphql = { "prettierd" },
        handlebars = { "prettierd" },
      },
    },
  },
}