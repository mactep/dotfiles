packadd! vim-snippets

let g:coc_global_extensions = ['coc-snippets']
setlocal tabstop=4 shiftwidth=4 softtabstop=4

map <silent><leader>s :e %:p:s,.h$,.X123X,:s,.c$,.h,:s,.X123X$,.c,<CR>
