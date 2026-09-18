return {
  'nvim-neorg/neorg',
  lazy = false, -- Disable lazy loading if you want it to load immediately
  version = '*', -- Use the latest stable release
  config = function()
    require('neorg').setup {
      load = {
        ['core.defaults'] = {}, -- Loads default behaviour
        ['core.concealer'] = {}, -- Adds beautiful icons
        ['core.integrations.image'] = {},
        ['core.latex.renderer'] = {},
        ['core.dirman'] = { -- Directory manager
          config = {
            workspaces = {
              notes = '~/notes',
            },
          },
        },
      },
    }
  end,
}
