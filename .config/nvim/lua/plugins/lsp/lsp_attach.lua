local on_attach = function(client, bufnr)
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
  vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, bufopts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)

  vim.keymap.set({ "n", "v" }, "<space>f", function()
    vim.lsp.buf.format({ async = false })
    vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
  end, bufopts)

  if client.server_capabilities.completionProvider then
    vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
  end
  if client.server_capabilities.definitionProvider then
    vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
  end

  -- if client.name == "gopls" then
  --   if not client.server_capabilities.semanticTokensProvider then
  --     local semantic = client.config.capabilities.textDocument.semanticTokens
  --     client.server_capabilities.semanticTokensProvider = {
  --       full = true,
  --       legend = { tokenModifiers = semantic.tokenModifiers, tokenTypes = semantic.tokenTypes },
  --       range = true,
  --     }
  --   end
  -- end

  if client.server_capabilities.inlayHintProvider then
    vim.lsp.inlay_hint.enable(bufnr, true)
  end
end

-- Uses treesitter queries to find and format embedded graphql code
local format_embedded_graphql = function(bufnr)
  local embedded_code_query = [[
    ; query
    (
      (raw_string_literal) @injection.content (#match? @injection.content "mutation|query")
        (#set! injection.language "graphql")
    )
  ]]

  -- get the query result
  local query = vim.treesitter.query.parse("go", embedded_code_query)
  local parser = vim.treesitter.get_parser(bufnr, "go", {})
  local root = parser:parse()[1]:root()

  -- for each result
  for id, node in query:iter_captures(root, bufnr, 0, -1) do
    -- get the range
    local range = node:range()
    local start_row, start_col, end_row, end_col = range:start(), range:start(), range:end_(), range:end_()
    -- get the text from the range
    local text = vim.api.nvim_buf_get_lines(bufnr, start_row, end_row, false)

    -- pass the text to prettier or other formatter
    local formatter = "prettier --parser graphql"
    local formatted_text = vim.fn.system(formatter, text)

    -- replace the text in the buffer
    vim.api.nvim_buf_set_lines(bufnr, start_row, end_row, false, formatted_text)
  end
end

return function()
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
      local client = vim.lsp.get_client_by_id(ev.data.client_id)
      local buf = ev.buf

      if client and buf then
        on_attach(client, buf)
      end
    end,
  })
end
