return {
  'hakabol/gi-tract',
  dependencies = {
    'm00qek/baleia.nvim',
    'lewis6991/gitsigns.nvim',
    'barrettruth/diffs.nvim',
  },

  config = function() require('git-nvim').setup() end,
}

--return {
--  'hakabol/git_intergration',
--  dependencies = {
--    'm00qek/baleia.nvim',
--    'lewis6991/gitsigns.nvim',
--    'barrettruth/diffs.nvim',
--  },
--  config = function() require('git-nvim').setup() end,
--}
