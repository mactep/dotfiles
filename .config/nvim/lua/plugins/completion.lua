return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    config = function()
        vim.g.copilot_filetypes = { yaml = true, markdown = true, TelescopePrompt = false }
        vim.g.copilot_no_tab_map = true
        vim.cmd([[ imap <expr> <Plug>(vimrc:copilot-dummy-map) copilot#Accept("\<Tab>") ]])

        local cmp = require("cmp")

        cmp.setup({
            snippet = {
                expand = function(args)
                    vim.fn["vsnip#anonymous"](args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
                ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
                ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
                ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
                ["<C-e>"] = cmp.mapping({
                    i = cmp.mapping.abort(),
                    c = cmp.mapping.close(),
                }),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    local copilot_keys = vim.fn["copilot#Accept"]()
                    if cmp.visible() then
                        cmp.confirm({ select = true })
                    elseif copilot_keys ~= "" and type(copilot_keys) == "string" then
                        vim.api.nvim_feedkeys(copilot_keys, "n", true)
                    else
                        fallback()
                    end
                end, {
                    "i",
                    "s",
                }),
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "vsnip" },
            }, {
                { name = "path" },
                { name = "buffer" },
            }),
        })

        cmp.setup.filetype("gitcommit", {
            sources = cmp.config.sources({
                { name = "cmp_git" },
            }, {
                { name = "buffer" },
            }),
        })

        vim.cmd([[
        imap <expr> <C-j>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-j>'
        smap <expr> <C-j>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-j>'
        ]])
    end,
    dependencies = {
        {
            "hrsh7th/cmp-nvim-lsp",
            dependencies = {
                "neovim/nvim-lspconfig",
            },
        },
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-vsnip",
        "hrsh7th/vim-vsnip",
        {
            "github/copilot.vim",
            event = "InsertEnter",
            cmd = "Copilot",
            config = function()
                vim.g.copilot_filetypes = { yaml = true, markdown = true }
                vim.g.copilot_no_tab_map = true
                vim.cmd([[ imap <expr> <Plug>(vimrc:copilot-dummy-map) copilot#Accept("\<Tab>") ]])
            end,
        },
        -- not a dependency, but I'll keep it here for better syncronization
    },
}
