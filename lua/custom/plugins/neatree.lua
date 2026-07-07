return {
  {
    'Dan7h3x/neaterm.nvim',
    branch = 'stable',
    event = 'VeryLazy',
    opts = {
      -- Your custom options here (optional)
      float_width = 0.95,
      float_height = 0.95,
      vertical_width = 0.4,
      update_interval = 1000,
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'ibhagwan/fzf-lua',
    },
  },
}
