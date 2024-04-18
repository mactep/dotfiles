return {
  {
    "wellle/targets.vim",
    event = "BufRead",
  },
  {
    "tpope/vim-abolish",
    cmd = { "S", "Subvert", "SubvertAll" },
  },
  {
    "tpope/vim-surround",
    event = "InsertEnter",
  },
  {
    "romainl/vim-qf",
    event = "BufRead",
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
    end,
  },
  {
    "akinsho/toggleterm.nvim",
    enabled = false,
    cmd = { "ToggleTerm" },
    keys = {
      { -- this is sketchy and only works on kitty outside tmux
        "<C-`>",
        function() require("toggleterm").toggle(nil, nil, nil, "float") end,
        desc = "Toggle terminal",
        mode = { "n", "t", "i" },
      },
      {
        "<space>t",
        function() require("toggleterm").toggle(nil, nil, nil, "float") end,
        desc = "Toggle terminal",
      },
      {
        "<leader>lg",
        function() require("toggleterm").Lazygit:toggle() end,
        { noremap = true, silent = true }
      },
    },
    config = function()
      require("toggleterm").setup({
        on_open = function()
          -- treesitter folding lags the terminal
          vim.opt_local.foldmethod = "manual"
        end,
      })
      require("toggleterm").Lazygit = require("toggleterm.terminal").Terminal:new({
        cmd = "lazygit",
        hidden = true,
        direction = "float",
        on_open = function()
          vim.keymap.del("t", "<Esc>")
        end,
        on_close = function()
          vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
        end,
      })
    end,
  },
  {
    "Wansmer/treesj",
    keys = {
      -- { '<leader>st', function() require('treesj').toggle() end },
      { "tj", function() require("treesj").join() end },
      { "ts", function() require("treesj").split() end },
    },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = true,
  },
  {
    "godlygeek/tabular",
    cmd = { "Tabularize" },
  },
}
