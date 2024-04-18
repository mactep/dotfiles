vim.o.termguicolors = true

local colorschemes = {
  {
    "sainnhe/gruvbox-material",
    config = function()
      vim.g.gruvbox_material_palette = "mix"
      vim.g.gruvbox_invert_selection = 0
      vim.cmd.colorscheme("gruvbox-material")
    end,
  },
  {
    "ellisonleao/gruvbox.nvim",
    config = function()
      vim.cmd.colorscheme("gruvbox")
      vim.cmd([[ hi! link Folded CursorLineFold ]])
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
      theme = "onedark",
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
      background = {     -- :h background
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
    "folke/tokyonight.nvim",
    opts = {
      style = "moon", -- "storm", "night", "moon", "day"
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd.colorscheme("tokyonight")
    end,
  },
  {
    "talha-akram/noctis.nvim",
    config = function()
      local variants = { "azureus", "bordo", "minimus", "uva", "viola", }
      local variant = tonumber(vim.fn.trim(vim.fn.system("echo $((1 + RANDOM % " .. #variants .. "))")))

      vim.cmd.colorscheme("noctis_" .. variants[variant])
    end,
  },
  {
    "projekt0n/caret.nvim",
    config = function()
      vim.cmd.colorscheme("caret")
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

theme = 6

colorschemes[theme].lazy = false
colorschemes[theme].priority = 1000

return colorschemes
