-- makes it easier to go to lua files
vim.cmd([[ autocmd! BufEnter init.lua setlocal includeexpr='lua/'.v:fname | lcd %:p:h ]])

require('colorscheme')
require('keymaps')
require('settings')
require('plug')
