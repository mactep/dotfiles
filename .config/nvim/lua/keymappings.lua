-- TODO: replace 'vim.cmd'
vim.g.mapleader = ','

vim.cmd('nnoremap <silent><esc> :noh<return><esc>')

vim.cmd('vnoremap < <gv')
vim.cmd('vnoremap > >gv')

vim.cmd('nnoremap <C-s> :update<CR>')
vim.cmd('vnoremap <C-s> <C-C>:update<CR>')
vim.cmd('inoremap <C-s> <C-O>:update<CR>')

vim.cmd('nnoremap <C-j> <C-w>j')
vim.cmd('nnoremap <C-k> <C-w>k')
vim.cmd('nnoremap <C-h> <C-w>h')
vim.cmd('nnoremap <C-l> <C-w>l')

vim.cmd('nnoremap <A-l> :bn<CR>')
vim.cmd('nnoremap <A-h> :bp<CR>')
vim.cmd('command Bd bp|bd #')

vim.cmd([[ tnoremap <Esc> <C-\><C-n> ]])
vim.cmd([[ tnoremap <C-j> <C-\><C-n><C-w>j ]])
vim.cmd([[ tnoremap <C-k> <C-\><C-n><C-w>k ]])
vim.cmd([[ tnoremap <C-h> <C-\><C-n><C-w>h ]])
vim.cmd([[ tnoremap <C-l> <C-\><C-n><C-w>l ]])

-- Unfuck my screen
vim.cmd('nnoremap U :syntax sync fromstart<CR>:redraw!<CR>')

vim.cmd([[ nnoremap <Leader>s :%s/\<<C-r><C-w>\>/ ]])
