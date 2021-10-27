local present, FTerm = pcall(require, 'FTerm')
if present then
    map('n', '<leader>t', '<CMD>lua require("FTerm").toggle()<CR>', {noremap=true, silent=true})
    map('t', '<leader>t', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', {noremap=true, silent=true})

    vim.cmd([[
    augroup packer_user_config
        autocmd!
        autocmd FileType FTerm nnoremap <buffer><Esc> <Cmd>lua require('FTerm').close()<CR>
    augroup end
    ]])
end
