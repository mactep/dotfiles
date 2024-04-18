require("keymaps")
require("settings")
require("lazy_config")
require("abbrev")
require("neovide")

-- tests with the command-line window
-- vim.keymap.set("n", ":", "q:", { noremap = true })
vim.api.nvim_create_augroup("Cmdwin", {})
vim.api.nvim_create_autocmd("CmdwinEnter", {
  group = "Cmdwin",
  pattern = "*",
  callback = function()
    vim.cmd("startinsert")
    vim.keymap.set("n", "<Esc>", "<cmd>q<CR>", { buffer = true })
  end,
})
