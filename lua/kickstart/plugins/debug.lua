-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

---@module 'lazy'
---@type LazySpec
return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    'igorlfs/nvim-dap-view',

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'mason-org/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    'leoluz/nvim-dap-go',
    'mfussenegger/nvim-dap-python',

    'MunifTanjim/nui.nvim',
  },
  keys = {
    -- Debugger
    {
      '<leader>d',
      group = 'Debugger',
      nowait = true,
      remap = false,
    },
    {
      '<leader>b',
      function() require('dap').toggle_breakpoint() end,
      desc = 'Toggle Breakpoint',
      nowait = true,
      remap = false,
    },
    {
      '<F7>',
      function() require('dap-view').toggle() end,
      desc = 'Toggle DAP View',
    },
    {
      '<F5>',
      function() require('dap').continue() end,
      desc = 'Continue',
      nowait = true,
      remap = false,
    },
    {
      '<leader>dc',
      function() require('dap').continue() end,
      desc = 'Continue',
      nowait = true,
      remap = false,
    },
    {
      '<leader>di',
      function() require('dap').step_into() end,
      desc = 'Step Into',
      nowait = true,
      remap = false,
    },
    {
      '<leader>do',
      function() require('dap').step_over() end,
      desc = 'Step Over',
      nowait = true,
      remap = false,
    },
    {
      '<leader>du',
      function() require('dap').step_out() end,
      desc = 'Step Out',
      nowait = true,
      remap = false,
    },
    {
      '<leader>dr',
      function() require('dap').repl.open() end,
      desc = 'Open REPL',
      nowait = true,
      remap = false,
    },
    {
      '<leader>dl',
      function() require('dap').run_last() end,
      desc = 'Run Last',
      nowait = true,
      remap = false,
    },
    {
      '<leader>dq',
      function() require('dap').terminate() end,
      desc = 'Terminate',
    },
    {
      '<leader>db',
      function() require('dap').list_breakpoints() end,
      desc = 'List Breakpoints',
      nowait = true,
      remap = false,
    },
    {
      '<leader>de',
      function() require('dap').set_exception_breakpoints { 'all' } end,
      desc = 'Set Exception Breakpoints',
      nowait = true,
      remap = false,
    },
  },
  config = function()
    local dap = require 'dap'
    local dapview = require 'dap-view'
    dapview.setup()

    dap.configurations.rust = {
      {
        name = 'Debug Rust (codelldb)',
        type = 'codelldb',
        request = 'launch',
        program = function() return vim.fn.getcwd() .. '/target/debug/' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':t') end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
      },
    }

    dap.configurations.cpp = {
      {
        name = 'Launch file',
        type = 'cppdbg',
        request = 'launch',

        program = function() return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file') end,

        cwd = '${workspaceFolder}',
        stopAtEntry = true,

        -- 👇 ADD THESE LINES
        MIMode = 'gdb',
        miDebuggerPath = '/usr/bin/gdb',
      },
    }

    dap.configurations.c = dap.configurations.cpp

    dap.configurations.c = dap.configurations.cpp

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        'delve',
        'python',
        'cppdbg',
        'codelldb',
      },
    }

    -- Change breakpoint icons
    -- vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
    -- vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
    -- local breakpoint_icons = vim.g.have_nerd_font
    --     and { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' }
    --   or { Breakpoint = '●', BreakpointCondition = '⊜', BreakpointRejected = '⊘', LogPoint = '◆', Stopped = '⭔' }
    -- for type, icon in pairs(breakpoint_icons) do
    --   local tp = 'Dap' .. type
    --   local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
    --   vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
    -- end

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Install golang specific config
    require('dap-go').setup {
      delve = {
        -- On Windows delve must be run attached or it crashes.
        -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
        detached = vim.fn.has 'win32' == 0,
      },
    }
    require('dap-python').setup()
  end,
}
