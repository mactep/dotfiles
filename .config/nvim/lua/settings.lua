-- TODO: remove this after it's fixes
local opts_info = vim.api.nvim_get_all_options_info()

local opt = setmetatable({}, {
  __newindex = function(self, key, value)
    vim.o[key] = value
    local scope = opts_info[key].scope
    if scope == 'win' then
      vim.wo[key] = value
    elseif scope == 'buf' then
      vim.bo[key] = value
    end
  end
})

-- general
opt.clipboard = 'unnamed'
-- opt.completeopt = 'longest,menuone,noinsert,noselect'
opt.hidden = true
opt.inccommand = 'nosplit'
opt.list = true
opt.listchars = 'eol:¬,tab:..,trail:.'
opt.showmode = false
opt.wrap = false
opt.number = true
opt.scrolloff = 8
opt.splitbelow = true
opt.splitright = true
opt.undofile = true
opt.pumheight = 12
opt.helplang = 'en'
opt.updatetime = 500
opt.swapfile = false
vim.g.tex_flavor = 'latex'

-- identation
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.shiftround = true
opt.softtabstop = 2

-- terminal
vim.cmd('autocmd TermOpen * setlocal nonumber')
vim.cmd('autocmd TermOpen * startinsert')
