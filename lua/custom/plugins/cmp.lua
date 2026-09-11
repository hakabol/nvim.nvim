return {
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-path',
    },
    config = function()
      local cmp = require 'cmp'

      -- Normal insert-mode completion
      cmp.setup {
        completion = {
          autocomplete = {
            cmp.TriggerEvent.TextChanged,
          },
        },
      }

      -- : command-line completion
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' },
        }, {
          { name = 'cmdline' },
        }),
      })

      -- / and ? search completion
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' },
        },
      })
    end,
  },
}
