local keymaps = require("plugins.lsp.keymaps")
local mason = require("plugins.lsp.mason")

return {
  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    config = function()
      keymaps()
      mason()

      vim.diagnostic.config({
        virtual_text = false,
        float = {
          border = "rounded",
        },
      })

      -- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
    end,
    dependencies = {
      { "williamboman/mason.nvim", config = true, build = ":MasonUpdate" },
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      -- since it needs to be configure before lspconfig
      {
        "folke/neodev.nvim",
        opts = {
          library = { plugins = { "nvim-dap-ui" }, types = true },
        },
      },
      {
        "smjonas/inc-rename.nvim",
        config = true,
      },
    },
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "VeryLazy",
    ft = { "go", },
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.code_actions.gitsigns,
          null_ls.builtins.code_actions.refactoring,
        },
      })
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig", -- to make sure it's loaded before null-ls
      "ThePrimeagen/refactoring.nvim",
    },
  },
}
