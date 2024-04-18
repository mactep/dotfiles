-- Let's try copilot + omni completion
return {
  {
    enabled = true,
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    cmd = "Copilot",
    opts = {
      filetypes = {
        -- markdown = true,
        -- yaml = true,
        -- gitcommit = true,
        -- NeogitCommitMessage = true,
        ["*"] = true, -- enable for all and only disable the ones we don't want
      },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = {
          accept = "<C-o>",
          accept_word = false,
          accept_line = false,
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
      },
    },
    config = function(_, opts)
      require("copilot").setup(opts)

      vim.api.nvim_create_autocmd("CompleteDone", {
        group = vim.api.nvim_create_augroup("completion_done", {}),
        pattern = "*",
        command = "if pumvisible() == 0 | pclose | endif",
      })
    end,
  },
  {
    enabled = false,
    "github/copilot.vim",
    event = "InsertEnter",
    cmd = "Copilot",
    init = function()
      vim.g.copilot_filetypes = { yaml = true, markdown = true, TelescopePrompt = false, gitcommit = true }
      vim.keymap.set("i", "<C-o>", 'copilot#Accept("<CR>")', {
        expr = true,
        replace_keycodes = false
      })
      vim.g.copilot_no_tab_map = true
    end
  },
}

-- return {
--   "hrsh7th/nvim-cmp",
--   event = "InsertEnter",
--   config = function()
--     vim.g.copilot_filetypes = { yaml = true, markdown = true, TelescopePrompt = false, gitcommit = true }
--     vim.g.copilot_no_tab_map = true
--     vim.cmd([[ imap <expr> <Plug>(vimrc:copilot-dummy-map) copilot#Accept("\<Tab>") ]])
--
--     local cmp = require("cmp")
--
--     cmp.setup({
--       snippet = {
--         expand = function(args)
--           vim.snippet.expand(args.body)
--         end,
--       },
--       experimental = {
--         ghost_text = false,
--       },
--       mapping = cmp.mapping.preset.insert({
--         ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
--         ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
--         ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
--         ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
--         ["<C-e>"] = cmp.mapping({
--           i = cmp.mapping.abort(),
--           c = cmp.mapping.abort(),
--         }),
--         ["<C-o>"] = cmp.mapping(function(fallback)
--           vim.api.nvim_feedkeys(vim.fn["copilot#Accept"](vim.api.nvim_replace_termcodes("<Tab>", true, true, true)), "n",
--             true)
--         end),
--         ["<Tab>"] = cmp.mapping(function(fallback)
--           local copilot_keys = vim.fn["copilot#Accept"]()
--           if cmp.visible() then
--             cmp.confirm({ select = true })
--           elseif copilot_keys ~= "" and type(copilot_keys) == "string" then
--             vim.api.nvim_feedkeys(copilot_keys, "n", true)
--           elseif vim.snippet.jumpable(1) then
--             vim.snippet.jump(1)
--           else
--             fallback()
--           end
--         end, {
--           "i",
--           "s",
--         }),
--       }),
--       sources = cmp.config.sources({
--         { name = "nvim_lsp" },
--         { name = "nvim_lua" },
--       }, {
--         { name = "path" },
--         { name = "buffer" },
--         { name = "nvim_lsp_signature_help" },
--       }),
--     })
--
--     cmp.setup.filetype("gitcommit", {
--       sources = cmp.config.sources({
--         { name = "cmp_git" },
--       }, {
--         { name = "buffer" },
--       }),
--     })
--
--     -- `/` cmdline setup.
--     cmp.setup.cmdline("/", {
--       mapping = cmp.mapping.preset.cmdline(),
--       sources = {
--         { name = "buffer" }
--       }
--     })
--
--     -- `:` cmdline setup.
--     cmp.setup.cmdline(":", {
--       mapping = cmp.mapping.preset.cmdline(),
--       sources = cmp.config.sources({
--         { name = "path" }
--       }, {
--         {
--           name = "cmdline",
--           option = {
--             ignore_cmds = { "Man", "!" }
--           }
--         }
--       })
--     })
--   end,
--   dependencies = {
--     {
--       "hrsh7th/cmp-nvim-lsp",
--       dependencies = {
--         "neovim/nvim-lspconfig",
--       },
--     },
--     "hrsh7th/cmp-buffer",
--     "hrsh7th/cmp-path",
--     "hrsh7th/cmp-nvim-lsp-signature-help",
--     "hrsh7th/cmp-nvim-lua",
--     "hrsh7th/cmp-cmdline",
--   },
-- }
