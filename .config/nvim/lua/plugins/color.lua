return {
  {
    "sainnhe/gruvbox-material",
    config = function()
      vim.g.gruvbox_material_palette = "mix"
      vim.g.gruvbox_sign_column = "bg0"
      vim.g.gruvbox_material_sign_column_background = "none"
      vim.g.gruvbox_invert_selection = 0
      vim.cmd.colorscheme("gruvbox-material")
    end,
  },
  { "gruvbox-community/gruvbox" },
  {
    "AlexvZyl/nordic.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("nordic")
    end,
  },
}
