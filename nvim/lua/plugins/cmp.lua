return {
  {
    "hrsh7th/nvim-cmp",
    version = false, -- last release is way too old
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    -- Not all LSP servers add brackets when completing a function.
    -- To better deal with this, LazyVim adds a custom option to cmp,
    -- that you can configure. For example:
    --
    -- ```lua
    -- opts = {
    --   auto_brackets = { "python" }
    -- }
    -- ```
    opts = function()
      vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
      local cmp = require("cmp")
      local defaults = require("cmp.config.default")()
      local auto_select = true
      return {
        auto_brackets = {}, -- configure any filetype to auto add brackets
        completion = {
          completeopt = "menu,menuone,noinsert" .. (auto_select and "" or ",noselect"),
        },
        preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None,
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = LazyVim.cmp.confirm({ select = auto_select }),
          ["<C-y>"] = LazyVim.cmp.confirm({ select = true }),
          ["<S-CR>"] = LazyVim.cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<C-CR>"] = function(fallback)
            cmp.abort()
            fallback()
          end,
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "path" },
        }, {
          { name = "buffer" },
        }),
        formatting = {
          format = function(entry, item)
            local icons = LazyVim.config.icons.kinds
            if icons[item.kind] then
              item.kind = icons[item.kind] .. item.kind
            end

            local widths = {
              abbr = vim.g.cmp_widths and vim.g.cmp_widths.abbr or 40,
              menu = vim.g.cmp_widths and vim.g.cmp_widths.menu or 30,
            }

            for key, width in pairs(widths) do
              if item[key] and vim.fn.strdisplaywidth(item[key]) > width then
                item[key] = vim.fn.strcharpart(item[key], 0, width - 1) .. "…"
              end
            end

            return item
          end,
        },
        experimental = {
          ghost_text = {
            hl_group = "CmpGhostText",
          },
        },
        sorting = defaults.sorting,
      }
    end,
    main = "lazyvim.util.cmp",
  },
  -- {
  --   "hrsh7th/nvim-cmp",
  --   commit = "cfafe0a1ca8933f7b7968a287d39904156f2c57d",
  --   dependencies = {
  --     {
  --       "hrsh7th/cmp-nvim-lsp",
  --       commit = "0e6b2ed705ddcff9738ec4ea838141654f12eeef",
  --     },
  --     {
  --       "hrsh7th/cmp-buffer",
  --       commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa",
  --     },
  --     {
  --       "hrsh7th/cmp-path",
  --       commit = "91ff86cd9c29299a64f968ebb45846c485725f23",
  --     },
  --     {
  --       "hrsh7th/cmp-cmdline",
  --       commit = "23c51b2a3c00f6abc4e922dbd7c3b9aca6992063",
  --     },
  --     {
  --       "saadparwaiz1/cmp_luasnip",
  --       commit = "18095520391186d634a0045dacaa346291096566",
  --     },
  --     {
  --       "L3MON4D3/LuaSnip",
  --       commit = "9bff06b570df29434a88f9c6a9cea3b21ca17208",
  --       event = "InsertEnter",
  --       dependencies = {
  --         "rafamadriz/friendly-snippets",
  --         commit = "a6f7a1609addb4e57daa6bedc300f77f8d225ab7",
  --       },
  --     },
  --     {
  --       "hrsh7th/cmp-nvim-lua",
  --       commit = "f3491638d123cfd2c8048aefaf66d246ff250ca6",
  --     },
  --   },
  --   event = {
  --     "InsertEnter",
  --     "CmdlineEnter",
  --   },
  --
  --   config = function()
  --     local cmp = require("cmp")
  --     local luasnip = require("luasnip")
  --     require("luasnip/loaders/from_vscode").lazy_load()
  --
  --     local check_backspace = function()
  --       local col = vim.fn.col(".") - 1
  --       return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
  --     end
  --
  --     local kind_icons = {
  --       Text = "󰙩",
  --       Method = "󰆧",
  --       Function = "󰆧",
  --       Constructor = "󰆧",
  --       Field = "",
  --       Variable = "",
  --       Class = "",
  --       Interface = "",
  --       Module = "󰅩",
  --       Property = "",
  --       Unit = "",
  --       Value = "",
  --       Enum = "",
  --       Keyword = "",
  --       Snippet = "",
  --       Color = "",
  --       File = "",
  --       Reference = "",
  --       Folder = "",
  --       EnumMember = "",
  --       Constant = "",
  --       Struct = "",
  --       Event = "",
  --       Operator = "",
  --       TypeParameter = "",
  --       Copilot = "",
  --     }
  --
  --     local has_words_before = function()
  --       if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
  --         return false
  --       end
  --       local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  --       return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
  --     end
  --
  --     cmp.setup({
  --       snippet = {
  --         expand = function(args)
  --           luasnip.lsp_expand(args.body) -- For `luasnip` users.
  --         end,
  --       },
  --       mapping = cmp.mapping.preset.insert({
  --         ["<C-k>"] = cmp.mapping.select_prev_item(),
  --         ["<C-j>"] = cmp.mapping.select_next_item(),
  --         ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
  --         ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
  --         ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
  --         ["<C-e>"] = cmp.mapping({
  --           i = cmp.mapping.abort(),
  --           c = cmp.mapping.close(),
  --         }),
  --         -- Accept currently selected item. If none selected, `select` first item.
  --         -- Set `select` to `false` to only confirm explicitly selected items.
  --         ["<CR>"] = cmp.mapping.confirm({ select = true }),
  --         ["<Tab>"] = cmp.mapping(function(fallback)
  --           if cmp.visible() and has_words_before() then
  --             cmp.select_next_item()
  --           elseif luasnip.expandable() then
  --             luasnip.expand()
  --           elseif luasnip.expand_or_jumpable() then
  --             luasnip.expand_or_jump()
  --           elseif check_backspace() then
  --             fallback()
  --           else
  --             fallback()
  --           end
  --         end, {
  --           "i",
  --           "s",
  --         }),
  --         ["<S-Tab>"] = cmp.mapping(function(fallback)
  --           if cmp.visible() then
  --             cmp.select_prev_item()
  --           elseif luasnip.jumpable(-1) then
  --             luasnip.jump(-1)
  --           else
  --             fallback()
  --           end
  --         end, {
  --           "i",
  --           "s",
  --         }),
  --       }),
  --       formatting = {
  --         fields = { "kind", "abbr", "menu" },
  --         format = function(entry, vim_item)
  --           vim_item.kind = kind_icons[vim_item.kind]
  --
  --           if entry.source.name == "copilot" then
  --             vim_item.kind = kind_icons["Copilot"]
  --             vim_item.kind_hl_group = "CmpItemKindCopilot"
  --           end
  --
  --           vim_item.menu = ({
  --             copilot = "",
  --             nvim_lsp = "",
  --             nvim_lua = "",
  --             luasnip = "",
  --             buffer = "",
  --             path = "",
  --             emoji = "",
  --           })[entry.source.name]
  --           return vim_item
  --         end,
  --       },
  --       sources = {
  --         { name = "copilot" },
  --         { name = "nvim_lsp" },
  --         { name = "nvim_lua" },
  --         { name = "luasnip" },
  --         { name = "buffer" },
  --         { name = "path" },
  --       },
  --       confirm_opts = {
  --         behavior = cmp.ConfirmBehavior.Replace,
  --         select = false,
  --       },
  --       window = {
  --         completion = cmp.config.window.bordered(),
  --         documentation = cmp.config.window.bordered(),
  --       },
  --       experimental = {
  --         ghost_text = true,
  --       },
  --     })
  --   end,
  -- },
}