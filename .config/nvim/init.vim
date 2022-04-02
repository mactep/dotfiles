" Neovim config
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

" Don't insert a comment on newline
augroup comments
    autocmd!
    autocmd BufEnter * set fo-=c fo-=r fo-=o
augroup END

" global statusline
" set laststatus=3
highlight WinSeparator guibg=None
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

nnoremap <A-l> <cmd>bn<CR>
nnoremap <A-h> <cmd>bp<CR>
" map('n', '<Backspace>', '<C-^>', {noremap=true})
" 
tnoremap <Esc> <C-\><C-n>
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-l> <C-\><C-n><C-w>l
" 
" map('n', '<Leader>s', [[:%s/\<<C-r><C-w>\>/ ]], {noremap=true})
" 
" don't save change operation to unnamed register
nnoremap c "_c
nnoremap C "_C

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

nnoremap <BS> <C-^>
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
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'jose-elias-alvarez/null-ls.nvim'
    Plug 'nvim-lua/plenary.nvim'

" colorscheme and highlighting
Plug 'sainnhe/gruvbox-material'
Plug 'gruvbox-community/gruvbox'
Plug 'yassinebridi/vim-purpura'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/playground'
Plug 'lukas-reineke/indent-blankline.nvim'

" git
Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim'
    Plug 'nvim-lua/plenary.nvim'

" tools
Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope-fzf-native.nvim', {'do': 'make'}
    Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'NTBBloodbath/rest.nvim'

" utility
Plug 'tpope/vim-abolish'
Plug 'ThePrimeagen/refactoring.nvim'
Plug 'norcalli/nvim-colorizer.lua'

call plug#end()
"}}}
" vim:fdm=marker:fdl=0
