local tabwidth = 2

vim.opt_local.tabstop = tabwidth
vim.opt_local.shiftwidth = tabwidth
vim.opt_local.softtabstop = tabwidth
vim.opt_local.expandtab = true

for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
  vim.api.nvim_set_hl(0, group, {})
end
