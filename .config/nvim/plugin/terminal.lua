local function go_to_file_from_terminal()
  local r = vim.fn.expand("<cfile>")
  if vim.fn.filereadable(vim.fn.expand(r)) ~= 0 then
    vim.cmd([[ edit ]] .. r)
  end

  vim.cmd([[normal! W]])

  local filename = nil
  local r1 = vim.fn.expand("<cWORD>")
  if vim.fn.filereadable(vim.fn.expand(r1)) ~= 0 then
    filename = r1
  else
    r1 = vim.split(r1, ":")[1]
    filename = r .. r1
  end

  vim.cmd([[ edit ]] .. filename)
end

vim.api.nvim_create_augroup("TerminalSettings", {})
vim.api.nvim_create_autocmd("TermOpen", {
  group = "TerminalSettings",
  pattern = "*",
  callback = function()
    vim.keymap.set(
      "n", "gf",
      go_to_file_from_terminal,
      { noremap = true, silent = true, buffer = true }
    )
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.cmd("startinsert")
  end,
})
