-- this should be loaded before the plugin.
-- waiting for a fix from de plugin side
vim.g.nvim_tree_auto_close = 1

local install_path = vim.fn.stdpath("data") .. "/site/pack/paqs/opt/paq-nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.cmd("!git clone https://github.com/savq/paq-nvim " .. install_path)
end

vim.cmd[[ packadd paq-nvim ]]
require 'paq' {
    {'savq/paq-nvim', opt=true};

    -- git
    'tpope/vim-fugitive';

    -- lsp
    'neovim/nvim-lspconfig';
    'kabouzeid/nvim-lspinstall';

    -- completion
    'hrsh7th/nvim-cmp';
    'hrsh7th/cmp-nvim-lsp';
    'hrsh7th/cmp-path';
    'hrsh7th/cmp-buffer';
    'saadparwaiz1/cmp_luasnip';
    'L3MON4D3/LuaSnip';
    'windwp/nvim-autopairs';
    'rafamadriz/friendly-snippets';

    -- colorscheme and highlighting
    'rktjmp/lush.nvim';
    'npxbr/gruvbox.nvim';
    'nvim-treesitter/nvim-treesitter';
    'norcalli/nvim-colorizer.lua';

    -- ui
    'lukas-reineke/indent-blankline.nvim';
    'kyazdani42/nvim-web-devicons';

    -- utility
    'camspiers/snap';
    'kyazdani42/nvim-tree.lua';
}

vim.cmd[[ PaqClean ]]
vim.cmd[[ PaqInstall ]]

local plugin_dir = vim.fn.stdpath('config')..'/lua/plugins_config'
local p = io.popen('find "'..plugin_dir..'" -type f -printf "%f\n"')
for file in p:lines() do
    file = string.gsub(file, ".lua", "")
    require('plugins_config/'..file)
end
