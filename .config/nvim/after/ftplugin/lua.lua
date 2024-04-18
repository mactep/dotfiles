local tabwidth = 2

vim.opt_local.tabstop = tabwidth
vim.opt_local.shiftwidth = tabwidth
vim.opt_local.softtabstop = tabwidth
vim.opt_local.expandtab = true

-- use gf to open required modules
-- Options to add `gf` functionality inside `.lua` files.
vim.opt_local.suffixesadd:prepend('.lua')
vim.opt_local.suffixesadd:prepend('init.lua')
vim.opt_local.path:prepend(vim.fn.stdpath('config')..'/lua')
