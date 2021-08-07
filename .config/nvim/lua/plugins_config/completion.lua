local present, compe = pcall(require, 'compe')
if present then
    vim.o.completeopt = 'menuone,noselect'

    compe.setup {
        source = {
            path = true;
            buffer = true;
            calc = false;
            nvim_lsp = true;
            nvim_lua = true;
            vsnip = true;
            ultisnips = true;
            luasnip = {priority = 100000};
        };
    }

    map("i", "<Tab>", "compe#confirm({ 'keys': '<Tab>', 'select': v:true })", { expr = true })
    vim.cmd([[
    inoremap <silent><expr> <C-f> compe#scroll({ 'delta': +4 })
    inoremap <silent><expr> <C-d> compe#scroll({ 'delta': -4 })
    ]])
end

local present, autopairs = pcall(require, 'nvim-autopairs')
if present then
    autopairs.setup{}
    require("nvim-autopairs.completion.compe").setup({
        map_complete = true,
        auto_select = false,
    })
end

local present, luasnip = pcall(require, 'luasnip')
if present then
    require("luasnip/loaders/from_vscode").lazy_load()
end
