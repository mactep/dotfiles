setlocal tabstop=2 shiftwidth=2 softtabstop=2

map <silent><leader>s :e %:p:s,.h$,.X123X,:s,.c$,.h,:s,.X123X$,.c,<CR>
