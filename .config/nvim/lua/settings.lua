-- general
vim.opt.clipboard = 'unnamed'
vim.opt.hidden = true
vim.opt.inccommand = 'nosplit'
vim.opt.list = true
vim.opt.listchars = 'eol:¬,tab:| ,trail:.'
vim.opt.showmode = false
vim.opt.wrap = false
vim.opt.number = true
vim.opt.scrolloff = 8
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.undofile = true
vim.opt.pumheight = 12
vim.opt.helplang = 'en'
vim.opt.updatetime = 500
vim.opt.swapfile = false
vim.g.tex_flavor = 'latex'

-- identation
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.shiftround = true
vim.opt.softtabstop = 4

-- terminal
vim.cmd('autocmd TermOpen * setlocal nonumber')
vim.cmd('autocmd TermOpen * startinsert')
