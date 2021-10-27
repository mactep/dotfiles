local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

require('packer').startup(function()
    use 'wbthomason/packer.nvim'

    if completion_engine == 'builtin' then
        -- lsp
        use 'neovim/nvim-lspconfig';
        use 'williamboman/nvim-lsp-installer';

        -- completion
        use 'hrsh7th/nvim-cmp';
        use 'hrsh7th/cmp-nvim-lsp';
        use 'hrsh7th/cmp-path';
        use 'hrsh7th/cmp-buffer';
        use 'saadparwaiz1/cmp_luasnip';
        use 'L3MON4D3/LuaSnip';
        use 'windwp/nvim-autopairs';
        use 'rafamadriz/friendly-snippets';
    else
        use {'neoclide/coc.nvim', branch = 'release'}
    end

    -- colorscheme and highlighting
    use 'rktjmp/lush.nvim';
    use 'npxbr/gruvbox.nvim';
    use 'nvim-treesitter/nvim-treesitter';
    use {
        'norcalli/nvim-colorizer.lua';
        config = function() require("colorizer").setup() end
    }
    use 'lukas-reineke/indent-blankline.nvim';

    -- git
    use 'tpope/vim-fugitive';
    use {
        'lewis6991/gitsigns.nvim',
        requires = {
            'nvim-lua/plenary.nvim'
        },
    }

    -- tools
    use 'numToStr/FTerm.nvim';
    use 'nvim-telescope/telescope.nvim';
    use 'NTBBloodbath/rest.nvim';

    if completion_engine == 'builtin' then
        use {
            'kyazdani42/nvim-tree.lua',
            requires = 'kyazdani42/nvim-web-devicons'
        }
    end

    -- utility
    use 'nvim-lua/plenary.nvim';
    use {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make'
    };
    use 'tpope/vim-abolish';
    use 'ThePrimeagen/refactoring.nvim';

    if packer_bootstrap then
        require('packer').sync()
    end
end)

local setup = function(plugin_name, config)
    local present, plugin = pcall(require, plugin_name)
    if present then
        plugin.setup(config)
    end
end
