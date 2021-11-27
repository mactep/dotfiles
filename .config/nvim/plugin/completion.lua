local present, cmp = pcall(require, 'cmp')
if not present then
    return
end

cmp.setup {
    sources = {
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'path' },
        { name = 'luasnip' }
    },
    snippet = {
        expand = function(args)
            require'luasnip'.lsp_expand(args.body)
        end
    },
    mapping = {
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<Tab>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        })
    }
}

local present, luasnip = pcall(require, 'luasnip/loaders/from_vscode')
if present then
    luasnip.lazy_load()
end

vim.api.nvim_set_keymap('i', '<C-j>', "luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<C-j>'", {silent=true, expr=true})
vim.api.nvim_set_keymap('i', '<C-k>', '<Plug>luasnip-jump-prev', {silent=true})
vim.api.nvim_set_keymap('s', '<C-j>', '<Plug>luasnip-jump-next', {silent=true})
vim.api.nvim_set_keymap('s', '<C-k>', '<Plug>luasnip-jump-prev', {silent=true})

local present, autopairs = pcall(require, 'nvim-autopairs')
if present then
    autopairs.setup{}
    require("nvim-autopairs.completion.cmp").setup({
        map_cr = true,
        map_complete = true,
    })
end
