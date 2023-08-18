local on_attach = require("plugins.lsp.on_attach")

return function()
  local mason_lspconfig = require("mason-lspconfig")
  local lspconfig = require("lspconfig")

  local capabilities = require("cmp_nvim_lsp").default_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  mason_lspconfig.setup({
    ensure_installed = {
      "lua_ls",
      "tsserver",
      "gopls",
      "texlab",
      "efm",
    },
  })

  local opts = { on_attach = on_attach, capabilities = capabilities }

  local custom_config = { "gopls", "lua_ls", "texlab", "efm" }
  local handlers = {
    function(server_name)
      lspconfig[server_name].setup(opts)
    end,
  }
  for _, server_name in ipairs(custom_config) do
    handlers[server_name] = function()
        lspconfig[server_name].setup(require("plugins.lsp." .. server_name))
      end
  end

  mason_lspconfig.setup_handlers(handlers)
end
