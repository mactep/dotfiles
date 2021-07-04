require('telescope').setup{
  defaults = {
    prompt_position = "top",
    sorting_strategy = "ascending",
    file_ignore_patterns = {
        "node_modules",
        "%.svg",
    }
  }
}

vim.api.nvim_command('nnoremap <leader>ff :Telescope find_files<CR>')
vim.api.nvim_command('nnoremap <leader>fg :Telescope git_files<CR>')
vim.api.nvim_command('nnoremap <leader>fr :Telescope live_grep<CR>')
vim.api.nvim_command('nnoremap <leader>fb :Telescope buffers<CR>')
vim.api.nvim_command('nnoremap <leader>fe :Telescope file_browser<CR>')
