local install_path = vim.fn.stdpath("data") .. "/site/pack/paqs/opt/paq-nvim"
local fresh_install = vim.fn.empty(vim.fn.glob(install_path))

if fresh_install > 0 then
  vim.cmd("!git clone https://github.com/savq/paq-nvim " .. install_path)
end

vim.cmd[[ packadd paq-nvim ]]
require 'paq' {
    {'savq/paq-nvim', opt=true};

    {'honza/vim-snippets', opt=true};
    'tpope/vim-fugitive';
    'neoclide/coc.nvim';
    'gruvbox-community/gruvbox';
    'nvim-treesitter/nvim-treesitter';
    'nvim-telescope/telescope.nvim';
    'nvim-lua/plenary.nvim';
    'nvim-lua/popup.nvim';
    'norcalli/nvim-colorizer.lua';
}

if fresh_install > 0 then
  vim.cmd[[ PaqInstall ]]
end
