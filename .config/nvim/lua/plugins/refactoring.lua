return {
  "ThePrimeagen/refactoring.nvim",
  config = function()
    require("refactoring").setup()
  end,
  cmd = {
    "Refactor",
  },
  keys = {
    {
      "<leader>rr",
      function()
        if pcall(require, "telescope") then
          require("telescope").extensions.refactoring.refactors()
        else
          require("refactoring").select_refactor()
        end
      end,
      mode = "v",
    },
  },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-lua/plenary.nvim",
  },
}
