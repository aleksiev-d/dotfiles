return {
  {
    "neanias/everforest-nvim",
    name = "everforest",
    priority = 1000,
    config = function()
      require("everforest").setup({
        background = "soft",
      })
      -- everforest-nvim ships an odd :terminal palette (black=fg, white=dark grey,
      -- pastel brights); replace it with the standard Everforest ANSI mapping.
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "everforest",
        callback = function()
          local ansi = {
            "#4d5960", "#e67e80", "#a7c080", "#dbbc7f", "#7fbbb3", "#d699b6", "#83c092", "#d3c6aa",
            "#859289", "#e67e80", "#a7c080", "#dbbc7f", "#7fbbb3", "#d699b6", "#83c092", "#d3c6aa",
          }
          for i, color in ipairs(ansi) do
            vim.g["terminal_color_" .. (i - 1)] = color
          end
        end,
      })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = { colorscheme = "everforest" },
  },
}
