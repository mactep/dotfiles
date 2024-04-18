local group = vim.api.nvim_create_augroup("lazygit", {})

vim.api.nvim_create_autocmd("TermOpen", {
  group = group,
  pattern = [[term://*lazygit]],
  callback = function()
    vim.cmd("startinsert")
    vim.keymap.del("t", "<Esc>")
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
  end,
})

vim.api.nvim_create_autocmd("TermClose", {
  group = group,
  pattern = [[term://*lazygit]],
  callback = function()
    vim.cmd([[ execute 'bwipe! ' . expand('<abuf>') ]])
    vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
  end,
})

local open_lazygit = function()
  vim.cmd("tabnew")
  vim.cmd("terminal lazygit")
end
vim.keymap.set("n", "<leader>lg", open_lazygit, { noremap = true, silent = true })
