-- Completion in Setup
require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"clangd",
		"gopls",
		--		"cmake-language-server",
		--		"codelldb",
		--		"lua-language-server",
		--		"pylint",
		"pyright",
		--		"python-lsp-server",
		--		"erlang-ls",
		--		"rust-analyzer",
		--		"typescript-language-server",
		--		"lua-language-server",
		--		"vim-language-server",
		"tailwindcss",
		--		"luaformatter",
		"phpactor",
	},
})


