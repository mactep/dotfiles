return {
  {
    "karb94/neoscroll.nvim",
    keys = {
      "<C-u>",
      "<C-d>",
      "<C-b>",
      "<C-f>",
      "zt",
      "zz",
      "zb",
    },
  },
  { "tpope/vim-abolish",  cmd = { "S", "Subvert", "SubvertAll" } },
  { "tpope/vim-surround", event = "InsertEnter", },
  { "romainl/vim-cool",   lazy = false },
  {
    "romainl/vim-qf",
    lazy = false,
    init = function()
      vim.keymap.set("n", "]q", "<Plug>(qf_qf_next)", { noremap = false })
      vim.keymap.set("n", "[q", "<Plug>(qf_qf_previous)", { noremap = false })
      vim.keymap.set("n", "<leader>q", "<Plug>(qf_qf_toggle)", { noremap = false })

      vim.g.qf_mapping_ack_style = 1
      vim.g.qf_auto_open_quickfix = 0

      local augroup = vim.api.nvim_create_augroup("qf_mappings", { clear = true })
      vim.api.nvim_create_autocmd({ "FileType" }, {
        pattern = "qf",
        group = augroup,
        callback = function()
          vim.keymap.set("n", "dd", "<cmd>.Reject<CR>", { buffer = true })
          vim.keymap.set("x", "d", "<cmd>'<,'>Reject<CR>", { buffer = true })
          vim.keymap.set("n", "{", "<Plug>(qf_previous_file)", { buffer = true })
          vim.keymap.set("n", "}", "<Plug>(qf_next_file)", { buffer = true })
        end,
      })
    end
  },
  {
    "akinsho/toggleterm.nvim",
    cmd = { "ToggleTerm" },
    keys = {
      { -- this is sketchy and only works on kitty outside tmux
        "<C-`>",
        function() require('toggleterm').toggle(nil, nil, nil, 'float') end,
        desc = "Toggle terminal",
        mode = { "n", "t", "i" },
      },
      {
        "<space>t",
        function() require('toggleterm').toggle(nil, nil, nil, 'float') end,
        desc = "Toggle terminal",
      },
    },
    config = true,
  },
  {
    'Wansmer/treesj',
    keys = {
      { '<leader>st', function() require('treesj').toggle() end },
      { 'gJ',         function() require('treesj').join() end },
      { 'gs',         function() require('treesj').split() end },
    },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = true,
  }
}
