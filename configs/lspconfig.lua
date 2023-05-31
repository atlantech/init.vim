local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
-- Replace <YOUR_LSP_SERVER> with each lsp server you"ve enabled.
require("lspconfig").erlangls.setup({})
require("lspconfig").lua_ls.setup({
	settings = { Lua = { diagnostics = { globals = { "vim" } } } },
})
require("lspconfig").tsserver.setup({})
require("lspconfig")["pyright"].setup({
	capabilities = capabilities,
})
require("lspconfig").phpactor.setup({})


