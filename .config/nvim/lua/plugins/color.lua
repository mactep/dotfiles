return {
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    config = function()
      vim.o.termguicolors = true
      vim.g.gruvbox_material_palette = "mix"
      vim.g.gruvbox_sign_column = "bg0"
      vim.g.gruvbox_material_sign_column_background = "none"
      vim.g.gruvbox_invert_selection = 0
      vim.cmd.colorscheme("gruvbox-material")
    end,
  },
  { "gruvbox-community/gruvbox", lazy = true },
  {
    "AlexvZyl/nordic.nvim",
    lazy = true,
    priority = 1000,
    config = function()
      vim.o.termguicolors = true
      vim.cmd.colorscheme("nordic")
    end,
  },
}
