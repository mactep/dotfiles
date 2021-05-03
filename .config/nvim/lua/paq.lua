vim.cmd 'packadd paq-nvim'
local paq = require'paq-nvim'.paq
paq{'savq/paq-nvim', opt=true}

paq{'honza/vim-snippets', opt=true}
paq 'tpope/vim-fugitive'
paq 'neoclide/coc.nvim'
paq 'gruvbox-community/gruvbox'
paq 'nvim-treesitter/nvim-treesitter'
paq 'nvim-telescope/telescope.nvim'
paq 'nvim-lua/plenary.nvim'
paq 'nvim-lua/popup.nvim'
