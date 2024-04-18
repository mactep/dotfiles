local global_keymaps = require("plugins.lsp.global_keymaps")
local lsp_attach = require("plugins.lsp.lsp_attach")
local ensure_installed = require("plugins.lsp.ensure_installed")
local lspconfig = require("plugins.lsp.lspconfig")
local diagnostics = require("plugins.lsp.diagnostics")
local hover = require("plugins.lsp.hover")

return {
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    config = function()
      ensure_installed()
      lspconfig()
      global_keymaps()
      lsp_attach()
      diagnostics()
      hover()
    end,
    dependencies = {
      -- since it needs to be configure before lspconfig
      -- "hrsh7th/cmp-nvim-lsp",
      -- dependencies = { "hrsh7th/nvim-cmp" },
      {
        "folke/neodev.nvim",
        opts = {
          library = { plugins = { "nvim-dap-ui" }, types = true },
        },
      },
    },
  },
}
