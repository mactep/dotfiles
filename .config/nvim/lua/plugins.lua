local install_path = vim.fn.stdpath("data") .. "/site/pack/paqs/opt/paq-nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.cmd("!git clone https://github.com/savq/paq-nvim " .. install_path)
end

vim.cmd[[ packadd paq-nvim ]]
require 'paq' {
    {'savq/paq-nvim', opt=true};

    {'honza/vim-snippets', opt=true};
    'tpope/vim-fugitive';
    {'neoclide/coc.nvim', branch='release'};
    'rktjmp/lush.nvim';
    'npxbr/gruvbox.nvim';
    'nvim-treesitter/nvim-treesitter';
    'norcalli/nvim-colorizer.lua';
    'lukas-reineke/indent-blankline.nvim';
    'rmagatti/auto-session';
    -- requires fzy installed via luarocks, waiting for https://github.com/camspiers/snap/issues/14
    {
        'camspiers/snap';
        run=[[ luarocks install fzy --local ]]
    };
}

vim.cmd[[ PaqClean ]]
vim.cmd[[ PaqInstall ]]

local plugin_dir = vim.fn.stdpath('config')..'/lua/plugins_config'
local p = io.popen('find "'..plugin_dir..'" -type f -printf "%f\n"')
for file in p:lines() do
    file = string.gsub(file, ".lua", "")
    require('plugins_config/'..file)
end
