local theme_detector_script = vim.fn.stdpath("config") .. "/assets/theme_detector.sh"
vim.fn.system(theme_detector_script)
local output = vim.v.shell_error

local theme = 1
if output == 1 then
  theme = 3
else
  vim.o.background = 'light'
end

local colorschemes = {
  {
    "sainnhe/gruvbox-material",
    config = function()
      vim.g.gruvbox_material_palette = "mix"
      -- vim.g.gruvbox_sign_column = "bg0"
      -- vim.g.gruvbox_material_sign_column_background = "none"
      vim.g.gruvbox_invert_selection = 0
      vim.cmd.colorscheme("gruvbox-material")
    end,
  },
  { "gruvbox-community/gruvbox" },
  {
    "AlexvZyl/nordic.nvim",
    config = function()
      require("nordic").load({
        bold_keywords = true,
      })
    end,
  },
}

colorschemes[theme].lazy = false
colorschemes[theme].priority = 1000

return colorschemes
