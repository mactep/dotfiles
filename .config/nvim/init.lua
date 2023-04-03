vim.cmd([[
" Settings {{{
set clipboard=unnamed
set hidden
set inccommand=nosplit
set list
set listchars=eol:¬,tab:\|\ ,trail:.
set noshowmode
set nowrap
set number
set relativenumber
set signcolumn=number
set scrolloff=8
set splitbelow
set splitright
set undofile
set noswapfile
set pumheight=12
set updatetime=500
set completeopt=menu,menuone,noselect
set splitkeep=screen

set termguicolors


" disable mouse
set mouse=

" identation
set expandtab
set tabstop=4
set shiftwidth=4
set shiftround
set softtabstop=4

" I don't do cpp
let g:c_syntax_for_h = 1

" terminal
autocmd TermOpen * setlocal nonumber norelativenumber
autocmd TermOpen * startinsert

" resizes splits equally after resizing vim
autocmd VimResized * wincmd =

" delete buffer but keep window
command Bd bn|bd #

" Don't insert a comment on newline
augroup comments
    autocmd!
    autocmd BufEnter * set fo-=c fo-=r fo-=o
augroup END

" global statusline
set laststatus=3
highlight WinSeparator guibg=None
" }}}
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

nnoremap <BS> <C-^>

" paste from clipboard keeping indentation
inoremap <M-p> <C-r><C-o>"
nnoremap <M-p> <C-r><C-o>"

" copy to system clipboard
nnoremap <leader>y "+y
vnoremap <leader>y "+y

" replace the word under the cursor
nnoremap <leader>s :%s/<C-r><C-w>/<C-r><C-r>//gc<left><left><left>
" }}}
]])

-- lazy.nvim {{{
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local opts = {
	defaults = {
		lazy = true,
	},
  dev = {
    path = "~/code",
    fallback = true, -- get plugin from git if not found in path
  },
}

local present, lazy = pcall(require, "lazy")
if not present then
	return
end

lazy.setup("plugins", opts)

-- }}}
-- vim:fdm=marker:fdl=0
