return {
  cmd = { "gopls" },
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
