local present, nvimtree = pcall(require, 'nvim-tree')
if present then
    local tree_cb = require'nvim-tree.config'.nvim_tree_callback
    local mappings = {
        { key = {'<CR>', 'l'}, cb = tree_cb('edit'), mode = 'n' },
        { key = {'<BS>', 'h'}, cb = tree_cb('close_node'), mode = 'n' },
    }

    nvimtree.setup {
        update_focused_file = {
            enable      = false,
        },
        view = {
            mappings = {
                list = mappings
            }
        }
    }


    map('n', '<C-n>', ':NvimTreeToggle<CR>', {noremap = true})
    map('n', '<leader>r', ':NvimTreeRefresh<CR>', {noremap = true})
end
