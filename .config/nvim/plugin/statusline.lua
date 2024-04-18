local cwd = "[%{fnamemodify(getcwd(), ':~')}/]"
local set_color_1 = "%#BufferVisible#"
local set_color_2 = "%#StatusLine#"
local relative_file = set_color_1 .. "%{expand('%:.')}" .. set_color_2

-- local default_statusline = "%<%f %h%m%r%=%-14.(%l,%c%V%) %P"
local wanted_statusline = cwd .. relative_file .. " %h%m%r%=%-14.(%l-%L %c%V%)"
vim.o.statusline = wanted_statusline
