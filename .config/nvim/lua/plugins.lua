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

    -- completion
    'hrsh7th/nvim-compe';
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

    -- util
    'rmagatti/auto-session';
    -- requires fzy installed via luarocks, waiting for https://github.com/camspiers/snap/issues/14
    { 'camspiers/snap'; run=[[ luarocks install fzy --local ]] };
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
