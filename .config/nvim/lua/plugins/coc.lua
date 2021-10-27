if completion_engine ~= 'coc' then
    return
end

-- coc.nvim bindings
vim.cmd('nmap <silent> [d <Plug>(coc-diagnostic-prev)')
vim.cmd('nmap <silent> ]d <Plug>(coc-diagnostic-next)')
vim.cmd('nmap <silent> gd <Plug>(coc-definition)')
vim.cmd('nmap <silent> gy <Plug>(coc-type-definition)')
vim.cmd('nmap <silent> gi <Plug>(coc-implementation)')
vim.cmd('nmap <silent> gr <Plug>(coc-references)')
vim.cmd('nmap <leader>rn <Plug>(coc-rename)')
vim.cmd('imap <C-j> <Plug>(coc-snippets-expand-jump)')
vim.cmd('inoremap <silent><expr> <c-space> coc#refresh()')
vim.cmd('xmap <leader>f  <Plug>(coc-format-selected)')
vim.cmd('nmap <leader>f  <Plug>(coc-format-selected)')
vim.cmd('nmap <space>f  <Plug>(coc-format)')

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

    augroup mygroup
    autocmd!
        " Highlight the symbol and its references when holding the cursor.
        autocmd CursorHold * silent call CocActionAsync('highlight')
        " Setup formatexpr specified filetype(s).
        autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
        " Update signature help on jump placeholder.
        autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    augroup end

    " Add `:Format` command to format current buffer.
    command! -nargs=0 Format :call CocAction('format')
    " Add `:OR` command for organize imports of the current buffer.
    command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

    if has('nvim-0.4.0') || has('patch-8.2.0750')
        nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
        nnoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
        inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
        inoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
        vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
        vnoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    endif
    " Remap keys for applying codeAction to the current buffer.
    nmap <leader>ca  <Plug>(coc-codeaction)
    " Apply AutoFix to problem on the current line.
    nmap <leader>qf  <Plug>(coc-fix-current)
]])

vim.g.coc_snippet_next = '<tab>'

-- coc-explorer
vim.g.coc_global_extensions = {'coc-explorer', 'coc-snippets', 'coc-go', 'coc-angular', 'coc-python', 'coc-tsserver'}
map('n', '<C-n>', ':CocCommand explorer<CR>', {noremap=true})
