return {
  "stevearc/conform.nvim",
  opts = function()
    ---@class ConformOpts
    local opts = {
      -- LazyVim will use these options when formatting with the conform.nvim formatter
      default_format_opts = {
        timeout_ms = 5000,
        async = false, -- not recommended to change
        quiet = false, -- not recommended to change
        lsp_fallback = false,
      },
      formatters_by_ft = {
        sh = { "beautysh" },
        css = { "prettierd" },
        dart = { "dart_cust" },
        go = { "goimports", "gofumpt" },
        graphql = { "prettierd" },
        handlebars = { "prettierd" },
        html = { "prettierd" },
        javascript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        json = { "prettierd" },
        jsonc = { "prettierd" },
        kotlin = { "ktlint" },
        less = { "prettierd" },
        lua = { "stylua" },
        markdown = { "prettierd" },
        php = { "php" },
        python = { "black" },
        scss = { "prettierd" },
        sql = { "sql_formatter", "sqlfluff" },
        typescript = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        vue = { "prettierd" },
        xml = { "xmlformat" },
        yaml = { "prettierd" },
      },
      -- The options you set here will be merged with the builtin formatters.
      -- You can also define any custom formatters here.
      formatters = {
        injected = { options = { ignore_errors = true } },
        -- # Example of using dprint only when a dprint.json file is present
        -- dprint = {
        --   condition = function(ctx)
        --     return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
        --   end,
        -- },
        --
        -- # Example of using shfmt with extra args
        -- shfmt = {
        --   prepend_args = { "-i", "2", "-ci" },
        -- },
        dart_cust = {
          command = "dart",
          args = { "format", "--line-length", "120" },
          -- stdin = false,
        },
        php = {
          command = "php-cs-fixer",
          args = {
            "fix",
            "$FILENAME",
          },
          stdin = false,
        },
      },
    }
    return opts
  end,
}