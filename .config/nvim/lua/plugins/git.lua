return {
  -- TODO: explore a "G*" approach to fugitive
  {
    "tpope/vim-fugitive", cmd = { "G", "Git" } },
  {
    "lewis6991/gitsigns.nvim",
    event = "BufRead",
    opts = {
      numhl = true,
      signcolumn = false,
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    'sindrets/diffview.nvim',
    cmd = {
      "DiffviewOpen",
      "DiffviewFileHistory",
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
  },
  {
    'TimUntersberger/neogit',
    cmd = {
      "Neogit",
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
  }
}
