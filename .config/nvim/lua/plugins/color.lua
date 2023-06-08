vim.o.termguicolors = true

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
  {
    'gruvbox-community/gruvbox',
    config = function()
      vim.g.gruvbox_invert_selection = 0
      vim.cmd.colorscheme('gruvbox')
    end
  },
  {
    "AlexvZyl/nordic.nvim",
    config = function()
      require("nordic").load({
        bold_keywords = true,
        override = {
          FloatBorder = { fg = "#4C566A", },
          TelescopePreviewBorder = { fg = "#4C566A", },
          TelescopePromptBorder = { fg = "#4C566A", },
          TelescopeResultsBorder = { fg = "#4C566A", },
          Visual = { bg = "#363e4d", },
        },
        telescope = {
          -- Available styles: `classic`, `flat`.
          style = 'classic',
        },
      })
    end,
  },
  {
    -- Duskfox for outrun aesthetic
    "EdenEast/nightfox.nvim",
    config = function()
      local variants = { "duskfox", "nightfox", "nordfox" }
      local variant = tonumber(vim.fn.trim(vim.fn.system("echo $((1 + RANDOM % " .. #variants .. "))")))
      vim.cmd.colorscheme(variants[variant])
    end
  },
  {
    "sainnhe/everforest",
    config = function()
      vim.g.everforest_background = "medium"
      vim.cmd.colorscheme("everforest")
    end,
  },
  {
    "maxmx03/fluoromachine.nvim",
    config = function()
      require('fluoromachine').setup {
        glow = true,
        theme = 'fluoromachine',
      }

      vim.cmd.colorscheme('fluoromachine')
    end,
  },
  {
    'glepnir/oceanic-material',
    config = function()
      vim.g.oceanic_material_style = 'oceanic'
      vim.cmd.colorscheme('oceanic_material')
    end,
  },
}

local function light_variant()
  local background_detector_script = vim.fn.stdpath("config") .. "/assets/theme_detector.sh"
  local output = vim.fn.system(background_detector_script)

  if output ~= 1 then
    vim.o.background = 'light'
  end
end

-- using this to avoid a compiled random number
local theme = tonumber(vim.fn.trim(vim.fn.system("echo $((1 + RANDOM % " .. #colorschemes .. "))")))

colorschemes[theme].lazy = false
colorschemes[theme].priority = 1000

return colorschemes
