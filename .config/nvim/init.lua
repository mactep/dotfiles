-- makes it easier to go to lua files
vim.cmd([[ autocmd! BufEnter init.lua setlocal includeexpr='lua/'.v:fname | lcd %:p:h ]])

require('colorscheme')
require('keymaps')
require('settings')
require('plug')

local plugin_dir = vim.fn.stdpath('config')..'/lua/plugins'
local p = io.popen('find "'..plugin_dir..'" -type f -printf "%f\n"')
for file in p:lines() do
    file = string.gsub(file, ".lua", "")
    require('plugins/'..file)
end
