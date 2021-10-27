local present, indent_blankline = pcall(require, 'indent_blankline')
if present then
    indent_blankline.setup {
        char = '│',
        show_first_indent_level = false,
        buftype_exclude = {'terminal'},
        filetype_exclude = {'NvimTree'},
    }
end
