-- makes it easier to go to lua files
vim.cmd([[ autocmd! BufEnter init.lua setlocal includeexpr='lua/'.v:fname | lcd %:p:h ]])

require('plugins/paq')
require('colorscheme')
require('keymappings')
require('settings')
require('plugins/coc')
require('plugins/telescope')
require('plugins/treesitter')
require('plugins/nvim-colorizer')
