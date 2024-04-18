local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local opts = {
  defaults = {
    lazy = true,
  },
  dev = {
    path = "~/code",
    fallback = true, -- get plugin from git if not found in path
  },
}

local present, lazy = pcall(require, "lazy")
if not present then
  return
end

-- setting the config one by one so it's easier to debug
lazy.setup({
  require("plugins.color"),
  require("plugins.completion"),
  require("plugins.dap"),
  require("plugins.git"),
  require("plugins.lsp"),
  require("plugins.notes"),
  require("plugins.refactoring"),
  require("plugins.telescope"),
  require("plugins.test"),
  require("plugins.treesitter"),
  require("plugins.ui"),
  require("plugins.util"),
  require("plugins.ux"),
}, opts)
