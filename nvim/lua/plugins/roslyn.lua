return {
  "seblyng/roslyn.nvim",
  ---@module 'roslyn.config'
  ---@type RoslynNvimConfig
  -- Load eagerly instead of on `ft = { "cs", "razor" }`. The plugin's
  -- plugin/roslyn.lua calls vim.lsp.enable("roslyn") the moment it is sourced,
  -- which happens *before* lazy.nvim runs setup(opts). With ft-loading the
  -- first C# buffer therefore attaches with default config (no choose_target),
  -- spawning a rootless server, and a second server once opts are applied.
  lazy = false,
  opts = {
    -- When a file's project is listed in both a solution (.sln/.slnx) and a
    -- solution filter (.slnf), roslyn.nvim sees multiple targets and refuses
    -- to pick one, leaving the buffer in "miscellaneous files" mode.
    -- Prefer the full solution over any filter. If more than one full
    -- solution remains, return nil so the plugin falls back to its default
    -- behaviour (`:Roslyn target`).
    choose_target = function(targets)
      local solutions = vim.tbl_filter(function(t)
        return t:match("%.slnx?$") ~= nil
      end, targets)
      if #solutions == 1 then
        return solutions[1]
      end
      return nil
    end,
  },
}
