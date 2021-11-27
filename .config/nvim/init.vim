" vim:fdm=marker:fdl=0
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

" identation
set expandtab
set tabstop=4
set shiftwidth=4
set shiftround
set softtabstop=4

" terminal
autocmd TermOpen * setlocal nonumber norelativenumber
autocmd TermOpen * startinsert

" resizes splits equally after resizing vim
autocmd VimResized * wincmd =

command Bd bp|bd #

augroup comments
    autocmd!
    autocmd BufEnter * set fo-=c fo-=r fo-=o
augroup END
" }}}
" Keymaps {{{
let mapleader = ","

nnoremap <silent><esc> :noh<CR><esc>

vnoremap < <gv
vnoremap > >gv

nnoremap <C-s> :update<CR>
vnoremap <C-s> <C-C>:update<CR>
inoremap <C-s> <C-O>:update<CR>

nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" map('n', '<A-l>', ':bn<CR>', {noremap=true})
" map('n', '<A-h>', ':bp<CR>', {noremap=true})
" map('n', '<Backspace>', '<C-^>', {noremap=true})
" 
" map('t', '<Esc>', [[<C-\><C-n> ]], {noremap=true})
" map('t', '<C-j>', [[<C-\><C-n><C-w>j ]], {noremap=true})
" map('t', '<C-k>', [[<C-\><C-n><C-w>k ]], {noremap=true})
" map('t', '<C-h>', [[<C-\><C-n><C-w>h ]], {noremap=true})
" map('t', '<C-l>', [[<C-\><C-n><C-w>l ]], {noremap=true})
" 
" map('n', '<Leader>s', [[:%s/\<<C-r><C-w>\>/ ]], {noremap=true})
" 
" -- don't save change operation to unnamed register
" map('n', 'c', '"_c', {noremap=true})
" map('n', 'C', '"_C', {noremap=true})
" 
" -- dot repetition over visual line selections
" map('x', '.', ':norm.<CR>', {noremap=true})

" center the screen after jumping
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

" move the selected text up and down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

nnoremap gf <cmd>e <cfile><cr>
" }}}
" Plugins {{{
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(stdpath('data') . '/plugged')

" completion
Plug 'github/copilot.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" colorscheme and highlighting
Plug 'sainnhe/gruvbox-material'
Plug 'gruvbox-community/gruvbox'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'lukas-reineke/indent-blankline.nvim'

" git
Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim'
    Plug 'nvim-lua/plenary.nvim'

" tools
Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope-fzf-native.nvim', {'do': 'make'}
Plug 'NTBBloodbath/rest.nvim'

" utility
Plug 'tpope/vim-abolish'
Plug 'ThePrimeagen/refactoring.nvim'

" note taking
Plug 'vimwiki/vimwiki', {'branch': 'dev'}

call plug#end()
"}}}
