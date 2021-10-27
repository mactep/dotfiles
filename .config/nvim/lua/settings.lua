-- general
vim.opt.clipboard = 'unnamed'
vim.opt.hidden = true
vim.opt.inccommand = 'nosplit'
vim.opt.list = true
vim.opt.listchars = 'eol:¬,tab:| ,trail:.'
vim.opt.showmode = false
vim.opt.wrap = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.pumheight = 12
vim.opt.updatetime = 500
-- vim.opt.helplang = 'en'
-- vim.g.tex_flavor = 'latex'

-- identation
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.shiftround = true
vim.opt.softtabstop = 4

-- terminal
vim.cmd('autocmd TermOpen * setlocal nonumber norelativenumber')
vim.cmd('autocmd TermOpen * startinsert')

-- resizes splits equally after resizing vim
vim.cmd([[autocmd VimResized * wincmd =]])

-- puts the sign column in the number column
vim.opt.signcolumn='number'

vim.cmd('command Bd bp|bd #')

-- vim.cmd([[:let &winheight = &lines * 7 / 10]])
-- vim.cmd([[:let &winwidth = &columns * 7 / 10]])
