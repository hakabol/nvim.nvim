return {
  {
    dir = '~/git-nvim',
    dependencies = {
      'm00qek/baleia.nvim',
      'lewis6991/gitsigns.nvim',
      'barrettruth/diffs.nvim',
    },

    config = function() require('git-nvim').setup() end,
  },
}
