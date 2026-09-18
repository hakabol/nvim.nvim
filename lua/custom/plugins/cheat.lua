return {
  'hakabol/cheat-sheet.nvim',
  dependencies = {
    'ibhagwan/fzf-lua',
    'm00qek/baleia.nvim',
  },
  config = function() require('cheat-sheet').setup() end,
}
