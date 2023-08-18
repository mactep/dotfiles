local on_attach = require("plugins.lsp.on_attach")

return {
  cmd = {
    "efm-langserver",
    "-logfile",
    "/home/mactep/.local/share/nvim/mason/packages/efm/logs",
    "-loglevel",
    "5",
  },
  on_attach = on_attach,
  init_options = {
    documentFormatting = true,
    hover = true,
    documentSymbol = true,
    codeAction = true,
    completion = true,
  },
  settings = {
    languages = {
      go = {
        {
          lintCommand = "revive -formatter unix -config " .. vim.fn.stdpath("config") .. "/assets/revive.toml",
          lintIgnoreExitCode = true,
          lintFormats = { "%f:%l:%c: %m" },
        },
      },
      yaml = {
        { formatCommand = "prettier --stdin --stdin-filepath ${INPUT}", formatStdin = true }
      },
      json = {
        { lintCommand = "jq ." },
      },
    },
  },
  filetypes = { "go", "yaml", "json" },
  single_file_support = true,
}
