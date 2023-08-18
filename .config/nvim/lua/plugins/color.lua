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
    "gruvbox-community/gruvbox",
    config = function()
      vim.g.gruvbox_invert_selection = 0
      vim.cmd.colorscheme("gruvbox")
    end
  },
  {
    "AlexvZyl/nordic.nvim",
    opts = {
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
        style = "classic",
      },
    },
    config = function(_, opts)
      require("nordic").load(opts)
    end,
  },
  {
    -- Duskfox for outrun aesthetic
    "EdenEast/nightfox.nvim",
    config = function()
      vim.cmd.colorscheme("duskfox")
    end
  },
  {
    "maxmx03/fluoromachine.nvim",
    opts = {
      glow = true,
      theme = "fluoromachine",
    },
    config = function(_, opts)
      require("fluoromachine").setup(opts)
      vim.cmd.colorscheme("fluoromachine")
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      background = { -- :h background
        light = "latte",
        dark = "mocha",
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin")
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    config = function()
      local variants = { "wave", "dragon" }
      local variant = tonumber(vim.fn.trim(vim.fn.system("echo $((1 + RANDOM % " .. #variants .. "))")))

      vim.cmd.colorscheme("kanagawa-" .. variants[variant])
    end,
  },
  {
    "tiagovla/tokyodark.nvim",
    config = function(_, opts)
      require("tokyodark").setup(opts)
      vim.cmd.colorscheme("tokyodark")
    end,
  },
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "moon", -- "storm", "night", "moon", "day"
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd.colorscheme("tokyonight")
    end,
  }
}

local function light_variant()
  local background_detector_script = vim.fn.stdpath("config") .. "/assets/theme_detector.sh"
  local output = vim.fn.system(background_detector_script)

  if output ~= 1 then
    vim.o.background = "light"
  end
end

-- using this to avoid a compiled random number
local theme = tonumber(vim.fn.trim(vim.fn.system("echo $((1 + RANDOM % " .. #colorschemes .. "))")))

colorschemes[theme].lazy = false
colorschemes[theme].priority = 1000

return colorschemes
