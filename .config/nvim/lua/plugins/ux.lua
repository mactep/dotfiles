Lazygit = nil

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
      {
        "<leader>G",
        function() Lazygit:toggle() end,
        { noremap = true, silent = true }
      },
    },
    config = function()
      local Terminal = require('toggleterm.terminal').Terminal
      Lazygit = Terminal:new({
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
    'Wansmer/treesj',
    keys = {
      -- { '<leader>st', function() require('treesj').toggle() end },
      { 'tj', function() require('treesj').join() end },
      { 'ts', function() require('treesj').split() end },
    },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = true,
  },
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
    init = function()
      vim.g.tmux_navigator_no_mappings = 1
      vim.g.tmux_navigator_disable_when_zoomed = 1

      vim.cmd([[
        noremap <silent> {Left-Mapping} :<C-U>TmuxNavigateLeft<cr>
        noremap <silent> {Down-Mapping} :<C-U>TmuxNavigateDown<cr>
        noremap <silent> {Up-Mapping} :<C-U>TmuxNavigateUp<cr>
        noremap <silent> {Right-Mapping} :<C-U>TmuxNavigateRight<cr>
        noremap <silent> {Previous-Mapping} :<C-U>TmuxNavigatePrevious<cr>
      ]])
    end,
  },
}
