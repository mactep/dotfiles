local present, lspconfig = pcall(require, 'lspconfig')
if not present then
    return
end

local opts = { noremap=true, silent=true }
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float,    opts)
vim.keymap.set("n", "[d",       vim.diagnostic.goto_prev,     opts)
vim.keymap.set("n", "]d",       vim.diagnostic.goto_next,     opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist,    opts)

local on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local bufopts = { noremap=true, silent=true, buffer=bufnr }
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

local capabilities
present = pcall(require, 'cmp')
if present then
    capabilities = require('cmp_nvim_lsp').default_capabilities()
else
    capabilities = vim.lsp.protocol.make_client_capabilities()
end
capabilities.textDocument.completion.completionItem.snippetSupport = true

local present, mason = pcall(require, 'mason')
if not present then
    return
end
mason.setup({})

local present, mason_lspconfig = pcall(require, 'mason-lspconfig')
if not present then
    return
end

mason_lspconfig.setup({
	ensure_installed = {
		"sumneko_lua",
		"tsserver",
		"gopls",
		"texlab",
	}
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
            }
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
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { 'vim' },
                    }
                }
            },
            on_attach = function(client, bufrn)
                client.server_capabilities.document_formatting = false
                client.server_capabilities.document_range_formatting = false
                on_attach(client, bufrn)
            end
        })
    end
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = {
      severity_limit = "Hint",
    },
    signs = {
      severity_limit = "Hint",
    },
    virtual_text = false,
  }
)
