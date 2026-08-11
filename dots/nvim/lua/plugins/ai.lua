return {
  'kkrampis/codex.nvim',
  lazy = true,
  cmd = { 'Codex', 'CodexToggle' },
  keys = {
    {
      '<leader>cc',
      function() require('codex').toggle() end,
      desc = 'Toggle Codex popup or side-panel',
      mode = { 'n', 't' }
    },
  },
}
