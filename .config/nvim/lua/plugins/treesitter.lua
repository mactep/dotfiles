local present, treesitter_configs = pcall(require, 'nvim-treesitter.configs')
if present then
    treesitter_configs.setup({
    ensure_installed = {
        'c', 'html', 'python', 'javascript', 'typescript', 'lua', 'go',
        'comment', 'css'
    },
    highlight = { enable = true },
    })
end
