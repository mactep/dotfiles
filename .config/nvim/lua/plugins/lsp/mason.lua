return function()
  require("mason").setup()

  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  local opts = { capabilities = capabilities }

  local custom_config = { "gopls", "lua_ls", "texlab", "efm", "tsserver" }
  local handlers = {
    function(server_name)
      require("lspconfig")[server_name].setup(opts)
    end,
  }
  for _, server_name in ipairs(custom_config) do
    handlers[server_name] = function()
      require("lspconfig")[server_name].setup(require("plugins.lsp." .. server_name))
    end
  end

  require("mason-lspconfig").setup({
    ensure_installed = {
      "lua_ls",
      "tsserver",
      "gopls",
      "texlab",
      "efm",
    },
    handlers = handlers,
  })
end
