return {
  {
    "neovim/nvim-lspconfig",
    ft = { "lua", "python", "go", "tex", "typescript", "javascript", "rust" },
    config = function()
      local map_opts = { noremap = true, silent = true }
      vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, map_opts)
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, map_opts)
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, map_opts)
      vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, map_opts)

      local on_attach = function(_, bufnr)
        vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
        vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
        vim.keymap.set("n", "<space>wl", function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, bufopts)
        vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
        vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
        vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
        vim.keymap.set("v", "<space>ca", vim.lsp.buf.code_action, bufopts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
        vim.keymap.set({ "n", "v" }, "<space>f", function()
          vim.lsp.buf.format({ async = true })
        end, bufopts)
      end

      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      local mason_lspconfig = require("mason-lspconfig")
      local lspconfig = require("lspconfig")

      mason_lspconfig.setup({
        ensure_installed = {
          "lua_ls",
          "tsserver",
          "gopls",
          "texlab",
        },
      })

      local opts = { on_attach = on_attach, capabilities = capabilities }
      mason_lspconfig.setup_handlers({
        function(server_name)
          lspconfig[server_name].setup(opts)
        end,
        ["gopls"] = function()
          lspconfig.gopls.setup({
            on_attach = on_attach,
            settings = {
              gopls = {
                gofumpt = true,
                analyses = {
                  shadow = true,
                  nilness = true,
                  unusedparams = true,
                  unusedwrite = true,
                  useany = true,
                },
                hints = {
                  assignVariableTypes = true,
                  compositeLiteralFields = true,
                  compositeLiteralTypes = true,
                  constantValues = true,
                  functionTypeParameters = true,
                  parameterNames = true,
                  rangeVariableTypes = true,
                },
                usePlaceholders = true,
                staticcheck = true,
              },
            },
          })
        end,
        ["lua_ls"] = function()
          lspconfig.lua_ls.setup({
            on_attach = on_attach,
            settings = {
              Lua = {
                diagnostics = {
                  globals = { "vim" },
                },
                format = {
                  enable = true,
                  defaultConfig = {
                    indent_style = "space",
                    indent_size = "2",
                    continuation_indent = "2", -- this is a workaround, remove later
                  }
                },
                completion = {
                  callSnippet = "Replace",
                },
              },
            },
          })
        end,
        ["texlab"] = function()
          lspconfig.texlab.setup({
            settings = {
              texlab = {
                build = {
                  executable = "tectonic",
                  args = { "%f", "--synctex", "--keep-logs", "--keep-intermediates" },
                },
              },
            },
          })
        end,
      })

      vim.diagnostic.config({
        virtual_text = false,
      })
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
      })
    end,
    dependencies = {
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      -- since it's a dependency, will be setted up before lspconfig
      { "folke/neodev.nvim",       config = true },
    },
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    ft = { "markdown", "python", "vimwiki", "go", "graphql" },
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          -- code actions
          null_ls.builtins.code_actions.gitsigns,
          null_ls.builtins.code_actions.gomodifytags,
          null_ls.builtins.code_actions.refactoring,
          -- formatting
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.isort,
          null_ls.builtins.formatting.prettierd,
          -- diagnostics
          null_ls.builtins.diagnostics.revive.with({
            args = {
              "-config", vim.fn.stdpath("config") .. "/assets/revive.toml",
              "-formatter", "json",
              "./..."
            },
          }),
        },
        diagnostics_format = "#{m} (#{s})",
        -- FIXME: this doesn't work. send PR to null-ls
        -- diagnostic_config = {
        --   virtual_text = false,
        -- },
        -- null-ls messes with formatexpr
        -- https://github.com/jose-elias-alvarez/null-ls.nvim/issues/1131#issuecomment-1432408485
        on_attach = function(_, bufnr)
          -- ignore unsaved buffers and such
          if (not bufnr) then
            return
          end
          vim.api.nvim_buf_set_option(bufnr, "formatexpr", "")
        end
      })
      vim.keymap.set("n", "<space>f", function()
        vim.lsp.buf.format({ async = true })
      end, { noremap = true, silent = true })
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig", -- to make sure it's loaded before null-ls
    },
  },
  {
    "lvimuser/lsp-inlayhints.nvim",
    ft = { "go" },
    init = function()
      require('lsp-inlayhints').setup()
      vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
      vim.api.nvim_create_autocmd("LspAttach", {
        group = "LspAttach_inlayhints",
        pattern = "*.go",
        callback = function(args)
          if not (args.data and args.data.client_id) then
            return
          end

          local bufnr = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          require("lsp-inlayhints").on_attach(client, bufnr, false)
        end,
      })
    end,
  },
}
