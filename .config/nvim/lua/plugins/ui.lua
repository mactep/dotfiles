return {
  {
    "lukas-reineke/indent-blankline.nvim",
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
    "kyazdani42/nvim-web-devicons",
    lazy = false,
  },
}
