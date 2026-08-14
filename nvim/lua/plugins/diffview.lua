return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewFileHistory" },
  keys = {
    {
      "<leader>gj",
      function()
        if next(require("diffview.lib").views) == nil then
          vim.cmd("DiffviewOpen")
        else
          vim.cmd("DiffviewClose")
        end
      end,
      desc = "Diffview toggle",
    },
    { "<leader>gH", "<cmd>DiffviewFileHistory %<cr>", desc = "File history (current file)" },
  },
}
