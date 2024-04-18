vim.o.clipboard = "unnamed"
vim.o.hidden = true
vim.o.list = true
vim.opt.listchars = {
  eol = "¬",
  space = " ",
  lead = " ",
  trail= "·",
  nbsp = "◇",
  tab = "│ ",
  extends = "▸",
  precedes = "◂",
  multispace = "·",
  leadmultispace = "│   "
}
vim.o.showmode = false
vim.o.wrap = false
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "number"
vim.o.scrolloff = 8
vim.o.sidescrolloff = 5
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.undofile = true
vim.o.swapfile = false
vim.o.updatetime = 500

vim.o.splitkeep = "screen"

-- disable mouse
vim.o.mouse = ""
--
-- indentation
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.shiftround = true
--
-- I don't do cpp
vim.g.c_syntax_for_h = true

-- global statusline
vim.o.laststatus = 3
-- highlight WinSeparator guibg=None

-- " Don't insert a comment on newline
vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("disableComments", {}),
  pattern = "*",
  command = "set fo-=c fo-=r fo-=o",
})
