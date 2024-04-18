return function()
  local lspconfig = require("lspconfig")

  -- local capabilities = require("cmp_nvim_lsp").default_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  -- capabilities.textDocument.completion.completionItem["snippetSupport"] = true

  local servers = { "efm", "lua_ls", "gopls", "texlab", "tsserver", "bufls" }
  for _, lsp in ipairs(servers) do
    local hasConfig, config = pcall(require, "plugins.lsp.configs." .. lsp)
    if hasConfig then
      require("lspconfig")[lsp].setup(vim.tbl_deep_extend("force", config, { capabilities = capabilities }))
    else
      require("lspconfig")[lsp].setup({ capabilities = capabilities })
    end
  end
end
