return {
  "williamboman/mason.nvim",
  opts = function(_, opts)
    table.insert(opts.ensure_installed, "eslint_d")
    table.insert(opts.ensure_installed, "black")
    table.insert(opts.ensure_installed, "codespell")
  end,
}
