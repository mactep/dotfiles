local map_opts = { noremap = true, silent = true }

return function()
  vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, map_opts)
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, map_opts)
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, map_opts)
  vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, map_opts)
end
