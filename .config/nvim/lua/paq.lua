local install_path = vim.fn.stdpath("data") .. "/site/pack/paqs/opt/paq-nvim"
local fresh_install = vim.fn.empty(vim.fn.glob(install_path))
if fresh_install > 0 then
  vim.cmd("!git clone https://github.com/savq/paq-nvim " .. install_path)
end

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

if fresh_install > 0 then
  vim.cmd[[ PaqInstall ]]
end
