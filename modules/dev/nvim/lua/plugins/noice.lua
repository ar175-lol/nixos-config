return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  opts = {
    cmdline = {
      enabled = true,
      view = "cmdline_popup",
    },
    messages = { enabled = true },
    popupmenu = { enabled = true },
    presets = {
      bottom_search = false,
      command_palette = true,
      long_message_to_split = true,
    },
  },
}
