local present, treesitter_configs = pcall(require, 'nvim-treesitter.configs')
if not present then
    return
end

treesitter_configs.setup({
  ensure_installed = {
      'c', 'html', 'python', 'javascript', 'typescript', 'lua', 'go',
      'comment', 'css'
  },
  highlight = { enable = true },
})
