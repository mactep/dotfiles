packadd! vim-snippets

let g:coc_global_extensions = ['coc-clangd', 'coc-snippets']
setlocal noet

map <silent><leader>s :e %:p:s,.h$,.X123X,:s,.c$,.h,:s,.X123X$,.c,<CR>
