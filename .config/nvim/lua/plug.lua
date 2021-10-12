local install_path = vim.fn.stdpath("data") .. "/site/pack/paqs/opt/paq-nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.cmd("!git clone https://github.com/savq/paq-nvim " .. install_path)
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plug.lua source <afile> | PaqSync
  augroup end
]])

vim.cmd[[ packadd paq-nvim ]]
require 'paq' {
    {'savq/paq-nvim', opt=true};

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
    'lukas-reineke/indent-blankline.nvim';

    -- tools
    'tpope/vim-fugitive';
    'numToStr/FTerm.nvim';
    'nvim-telescope/telescope.nvim';
    'NTBBloodbath/rest.nvim';

    -- utility
    'nvim-lua/plenary.nvim';
    {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' };
    'tpope/vim-abolish';

    -- golang
    'buoto/gotests-vim';
}
