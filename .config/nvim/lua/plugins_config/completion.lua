local present, compe = pcall(require, 'compe')
if not present then
    return
end

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
        luasnip = true;
    };
}

map("i", "<C-f>", "compe#scroll({ 'delta': +4 })", { noremap = true; silent = true; expr = true })
map("i", "<C-d>", "compe#scroll({ 'delta': -4 })", { noremap = true; silent = true; expr = true })

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

local present, tabout = pcall(require, 'tabout')
if present then
    tabout.setup{
        tabkey = "",
        backwards_tabkey = "",
    }
end

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

_G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return vim.fn['compe#confirm']({keys='<Tab>', select=true})
    elseif luasnip and luasnip.jumpable(1) then
        return t "<Plug>luasnip-jump-next"
    else
        return t "<Plug>(Tabout)"
    end
end
_G.s_tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-p>"
    elseif luasnip and luasnip.jumpable(-1) then
        return t "<Plug>luasnip-jump-prev"
    else
        -- If <S-Tab> is not working in your terminal, change it to <C-h>
        return t "<Plug>(TaboutBack)"
    end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

vim.cmd([[
imap <silent><expr> <C-j> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<C-j>'
inoremap <silent> <C-k> <cmd>lua require'luasnip'.jump(-1)<Cr>

snoremap <silent> <C-j> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <C-k> <cmd>lua require('luasnip').jump(-1)<Cr>
]])
