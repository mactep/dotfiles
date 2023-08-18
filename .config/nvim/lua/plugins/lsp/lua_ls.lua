local on_attach = require("plugins.lsp.on_attach")

return {
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT", -- since I only use it for neovim
      },
      diagnostics = {
        globals = { "vim" },
      },
      format = {
        enable = true,
        defaultConfig = {
          indent_style = "space",
          indent_size = "2",
          continuation_indent = "2", -- this is a workaround, remove later
          quote_style = "double",
        }
      },
      completion = {
        callSnippet = "Replace",
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
    },
  },
}
