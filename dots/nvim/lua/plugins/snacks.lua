return {
  "folke/snacks.nvim",
  opts = function(_, opts)
    local keys = {
      { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
      { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
      { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
      { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
      {
        icon = " ",
        key = "c",
        desc = "Config",
        action = ":lua Snacks.explorer.open({ cwd = vim.fn.stdpath('config') })",
      },
      { icon = " ", key = "s", desc = "Restore Session", section = "session" },
      { icon = " ", key = "e", desc = "LazyVim Extras", action = ":LazyExtra" },
      { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
      { icon = " ", key = "q", desc = "Quit", action = ":qa" },
    }
    opts.dashboard = {
      enabled = true,
      width = 36,
      rows = nil,
      preset = {
        keys = keys,
        header = nil,
      },
      formats = {
        key = function(item)
          return { { "[", hl = "special" }, { item.key, hl = "key" }, { "]", hl = "special" } }
        end,
        header = {
          hl = "SnacksIndent6",
        },
      },
      sections = {
        { padding = 1 },
        { section = "header" },
        { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
        { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
        { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
        { section = "startup" },
      },
    }
    opts.input = { enabled = false }
    return opts
  end,
}
