-- coc.nvim bindings
vim.cmd('nmap <silent> [g <Plug>(coc-diagnostic-prev)')
vim.cmd('nmap <silent> ]g <Plug>(coc-diagnostic-next)')
vim.cmd('nmap <silent> gd <Plug>(coc-definition)')
vim.cmd('nmap <silent> gy <Plug>(coc-type-definition)')
vim.cmd('nmap <silent> gi <Plug>(coc-implementation)')
vim.cmd('nmap <silent> gr <Plug>(coc-references)')
vim.cmd('nmap <leader>rn <Plug>(coc-rename)')
vim.cmd('imap <C-j> <Plug>(coc-snippets-expand-jump)')
vim.cmd('inoremap <silent><expr> <c-space> coc#refresh()')

vim.cmd([[
    function! ShowDocumentation()
        if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
        elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
        else
        execute '!' . &keywordprg . " " . expand('<cword>')
        endif
    endfunction

    nnoremap <silent> K :call ShowDocumentation()<CR>

    inoremap <silent><expr> <TAB> pumvisible() ? coc#_select_confirm() : coc#expandableOrJumpable() ?  "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" : Check_back_space() ? "\<TAB>" : coc#refresh()

    function! Check_back_space() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    let g:coc_snippet_next = '<tab>'
]])

-- coc-explorer
vim.cmd([[ let g:coc_global_extensions = ['coc-explorer'] ]])
vim.cmd([[ nnoremap <C-n> :CocCommand explorer<CR> ]])
