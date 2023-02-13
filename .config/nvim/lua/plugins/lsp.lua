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
        vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
        vim.keymap.set("n", "<space>f", function()
          vim.lsp.buf.format({ async = true })
        end, bufopts)
      end

      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      local mason_lspconfig = require("mason-lspconfig")
      local lspconfig = require("lspconfig")

      mason_lspconfig.setup({
        ensure_installed = {
          "sumneko_lua",
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
        ["pylsp"] = function()
          lspconfig.pylsp.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
              pylsp = {
                plugins = {
                  pycodestyle = { enabled = false },
                  yapf = { enabled = false },
                },
              },
            },
          })
        end,
        ["pyright"] = function()
          lspconfig.pyright.setup({
            on_attach = function(client, bufrn)
              client.server_capabilities.document_formatting = false
              client.server_capabilities.document_range_formatting = false
              on_attach(client, bufrn)
            end,
          })
        end,
        ["sumneko_lua"] = function()
          lspconfig.sumneko_lua.setup({
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

      vim.lsp.handlers["textDocument/publishDiagnostics"] =
        vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
          underline = {
            severity_limit = "Hint",
          },
          signs = {
            severity_limit = "Hint",
          },
          virtual_text = false,
        })
    end,
    dependencies = {
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    ft = { "markdown", "python", "vimwiki" },
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          -- formatting
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.isort,
          null_ls.builtins.formatting.markdownlint.with({
            extra_filetypes = { "vimwiki" },
          }),
          -- diagnostics
          null_ls.builtins.diagnostics.markdownlint.with({
            extra_filetypes = { "vimwiki" },
          }),
        },
      })
      -- vim.keymap.set("n", "<space>f", function()
      --   vim.lsp.buf.format({ async = true })
      -- end, { noremap = true, silent = true })
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
}
