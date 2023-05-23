return {
  "mfussenegger/nvim-dap",
  init = function()
    vim.fn.sign_define("DapBreakpoint", { text = "⬢", texthl = "Yellow", linehl = "", numhl = "Yellow" })
    vim.fn.sign_define("DapStopped", { text = "▶", texthl = "Green", linehl = "ColorColumn", numhl = "Green" })
  end,
  ft = {
    "go",
  },
  keys = {
    {
      '<leader>dc',
      function() require('dap').continue() end,
    },
    {
      '<leader>dv',
      function() require('dap').step_over() end,
    },
    {
      '<leader>di',
      function() require('dap').step_into() end,
    },
    {
      '<leader>do',
      function() require('dap').step_out() end,
    },
    {
      '<Leader>dt',
      function() require('dap').toggle_breakpoint() end,
    },
    {
      '<Leader>db',
      function() require('dap').set_breakpoint() end,
    },
    {
      '<Leader>dB',
      function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end,
    },
    {
      '<Leader>dr',
      function() require('dap').repl.open() end,
    },
    {
      '<Leader>dl',
      function() require('dap').run_last() end,
    },
    {
      mode = { 'n', 'v' },
      '<Leader>dh',
      function() require('dap.ui.widgets').hover() end,
    },
    {
      mode = { 'n', 'v' },
      '<Leader>dp',
      function() require('dap.ui.widgets').preview() end,
    },
    {
      '<Leader>df',
      function()
        local widgets = require('dap.ui.widgets')
        widgets.centered_float(widgets.frames)
      end,
    },
    {
      '<Leader>ds',
      function()
        local widgets = require('dap.ui.widgets')
        widgets.centered_float(widgets.scopes)
      end,
    },
  },
  dependencies = {
    {
      "theHamsta/nvim-dap-virtual-text",
      opts = {
      },
      dependencies = {
        "nvim-treesitter/nvim-treesitter",
      },
    },
    {
      "rcarriga/nvim-dap-ui",
      opts = {
      },
      keys = {
        {
          '<Leader>du',
          function() require('dapui').toggle() end,
        },
      },
    },
    {
      "leoluz/nvim-dap-go",
      opts = {
      },
    },
  },
}
