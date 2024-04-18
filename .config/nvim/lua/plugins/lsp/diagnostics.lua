return function()
  -- Show source in diagnostics
  vim.diagnostic.config({
    virtual_text = false,
    float = {
      source = "always", -- Or "if_many"
      border = "rounded",
    },
  })
end
