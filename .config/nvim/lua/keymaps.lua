map = vim.api.nvim_set_keymap

-- TODO: replace 'vim.cmd'
vim.g.mapleader = ','

map('n', '<esc>', ':noh<CR><esc>', {noremap=true, silent=true})

map('v', '<', '<gv', {noremap=true})
map('v', '>', '>gv', {noremap=true})

map('n', '<C-s>', ':update<CR>', {noremap=true})
map('v', '<C-s>', '<C-C>:update<CR>', {noremap=true})
map('i', '<C-s>', '<C-O>:update<CR>', {noremap=true})

map('n', '<C-j>', '<C-w>j', {noremap=true})
map('n', '<C-k>', '<C-w>k', {noremap=true})
map('n', '<C-h>', '<C-w>h', {noremap=true})
map('n', '<C-l>', '<C-w>l', {noremap=true})

map('n', '<A-l>', ':bn<CR>', {noremap=true})
map('n', '<A-h>', ':bp<CR>', {noremap=true})
map('n', '<Backspace>', '<C-^>', {noremap=true})

map('t', '<Esc>', [[<C-\><C-n> ]], {noremap=true})
map('t', '<C-j>', [[<C-\><C-n><C-w>j ]], {noremap=true})
map('t', '<C-k>', [[<C-\><C-n><C-w>k ]], {noremap=true})
map('t', '<C-h>', [[<C-\><C-n><C-w>h ]], {noremap=true})
map('t', '<C-l>', [[<C-\><C-n><C-w>l ]], {noremap=true})

map('n', '<Leader>s', [[:%s/\<<C-r><C-w>\>/ ]], {noremap=true})

-- don't save change operation to unnamed register
map('n', 'c', '"_c', {noremap=true})
map('n', 'C', '"_C', {noremap=true})

-- dot repetition over visual line selections
map('x', '.', ':norm.<CR>', {noremap=true})

-- center the screen after jumping
vim.cmd([[
nnoremap {  {zz
nnoremap }  }zz
nnoremap n  nzz
nnoremap N  Nzz
nnoremap ]c ]czz
nnoremap [c [czz
nnoremap [j <C-o>zz
nnoremap ]j <C-i>zz
nnoremap ]s ]szz
nnoremap [s [szz
nnoremap J mzJ`z
]])

vim.cmd([[
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv
]])
