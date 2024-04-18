return {
  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = false,
    event = "BufRead",
    opts = {
      show_current_context = true,
      buftype_exclude = { "terminal" },
      filetype_exclude = { "NvimTree" },
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },
  {
    "phelipetls/jsonpath.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },
  {
    "NvChad/nvim-colorizer.lua",
    cmd = { "ColorizerToggle", "ColorizerAttachToBuffer" },
    config = true,
  },
  {
    dir = "~/code/ccc.nvim",
    ft = "html",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },
}
