local on_attach = require("plugins.lsp.on_attach")

return {
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
      semanticTokens = true,
      usePlaceholders = true,
      staticcheck = true,
    },
  },
}
