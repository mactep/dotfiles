vim.o.clipboard = "unnamed"
vim.o.hidden = true
vim.o.list = true
-- set listchars=eol:¬,tab:\|\ ,trail:.
vim.opt.listchars:append({ eol = "¬", })
vim.o.showmode = false
vim.o.wrap = false
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "number"
vim.o.scrolloff = 8
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.undofile = true
vim.o.swapfile = false
-- vim.o.updatetime = 500

--
vim.o.splitkeep = "screen"

-- disable mouse
vim.o.mouse = ""
--
-- identation
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.shiftround = true
--
-- I don't do cpp
vim.g.c_syntax_for_h = true

-- global statusline
vim.o.laststatus = 3
-- highlight WinSeparator guibg=None

-- " Don't insert a comment on newline
vim.api.nvim_create_augroup("disableComments", {})
vim.api.nvim_create_autocmd("BufEnter", {
  group = "disableComments",
  pattern = "*",
  command = "set fo-=c fo-=r fo-=o",
})

vim.cmd([[
" Keymaps {{{
let mapleader = ","

" nnoremap <silent><esc> :noh<CR><esc>

vnoremap < <gv
vnoremap > >gv

nnoremap <C-s> :update<CR>
vnoremap <C-s> <C-C>:update<CR>
inoremap <C-s> <C-O>:update<CR>

nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

nnoremap <silent><A-l> <cmd>bn<CR>
nnoremap <silent><A-h> <cmd>bp<CR>
nnoremap <silent><A-d> <cmd>Bd<CR>
nnoremap <silent><S-A-d> <cmd>bd<CR>
nnoremap <silent>]b <cmd>bn<CR>
nnoremap <silent>[b <cmd>bp<CR>

nnoremap <silent>]q <cmd>cnext<CR>
nnoremap <silent>[q <cmd>cprev<CR>
nnoremap <silent>]Q <cmd>cfirst<CR>
nnoremap <silent>[Q <cmd>clast<CR>

" jump to<silent> next git conflict marker (<<<<<<<)
nnoremap <silent>]n /^<\{7\}\s\S*$<CR><cmd>nohl<CR>
nnoremap <silent>]n ?^<\{7\}\s\S*$<CR><cmd>nohl<CR>

tnoremap <Esc> <C-\><C-n>
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-l> <C-\><C-n><C-w>l

" don't save change operation to unnamed register
nnoremap c "_c
nnoremap C "_C

" -- dot repetition over visual line selections
" map('x', '.', ':norm.<CR>', {noremap=true})

" center the screen after jumping
nnoremap {  {zz
nnoremap }  }zz
nnoremap n  nzzzv
nnoremap N  Nzzzv
nnoremap ]c ]czz
nnoremap [c [czz
nnoremap [j <C-o>zz
nnoremap ]j <C-i>zz
nnoremap ]s ]szz
nnoremap [s [szz
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap J mzJ`z

" move the selected text up and down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

nnoremap gf <cmd>e <cfile><cr>

" paste from clipboard keeping indentation
inoremap <M-p> <C-r><C-o>"
nnoremap <M-p> <C-r><C-o>"

" copy to system clipboard
nnoremap <leader>y "+y
vnoremap <leader>y "+y

" replace the word under the cursor with the previous search
" nnoremap <leader>s :%s/<C-r><C-w>/<C-r><C-r>//gc<left><left><left>
" replace the word under the cursor
nnoremap <leader>s :%s/<C-r><C-w>/<C-r><C-w>/g<left><left>
" }}}
]])

require("lazy_config")

-- vim:fdm=marker:fdl=0
