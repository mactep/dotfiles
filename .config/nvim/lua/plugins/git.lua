return {
  -- TODO: explore a "G*" approach to fugitive
  {
    "tpope/vim-fugitive", cmd = { "G", "Git" } },
  {
    "lewis6991/gitsigns.nvim",
    lazy = false,
    opts = {
      numhl = true,
      signcolumn = false,
    },
    config = function(_, opts)
      vim.fn.system("git rev-parse --is-inside-work-tree")
      if vim.v.shell_error == 0 then
        require("gitsigns").setup(opts)
      end
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
}
