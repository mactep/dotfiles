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

if fresh_install > 0 then
  vim.cmd[[ PaqInstall ]]
end
