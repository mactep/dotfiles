local present, tree_config = pcall(require, 'nvim-tree.config')
if not present then
    return
end

local tree_cb = tree_config.nvim_tree_callback

vim.g.nvim_tree_bindings = {
    { key = {'<CR>', 'l'}, cb = tree_cb('edit') },
    { key = {'<BS>', 'h'}, cb = tree_cb('close_node') },
}

map('n', '<C-n>', ':NvimTreeToggle<CR>', {noremap = true})
map('n', '<leader>r', ':NvimTreeRefresh<CR>', {noremap = true})

vim.g.nvim_tree_auto_close = 1
