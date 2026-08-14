return {
  {
    "folke/snacks.nvim",
    opts = {
      styles = {
        terminal = {
          -- Use the editor background instead of the raised float bg
          -- (SnacksNormal -> NormalFloat #434f55) so the terminal matches bg0.
          wo = {
            winhighlight = "Normal:Normal,NormalNC:Normal,WinBar:SnacksWinBar,WinBarNC:SnacksWinBarNC,WinSeparator:SnacksWinSeparator,StatusLine:StatusLineTerm,StatusLineNC:StatusLineTermNC",
          },
        },
      },
    },
  },
}
