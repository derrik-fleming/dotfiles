return {
  {
    "saghen/blink.cmp",
    opts = function(_, opts)
      opts.completion.menu.border = "rounded"
      opts.completion.menu.winhighlight =
        "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None"
      opts.completion.documentation = {
        auto_show = true,

        window = {
          border = "rounded",
          winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
        },
      }
    end,
  },
}
