require("mason").setup()

local symbols_outline = require("symbols-outline")
symbols_outline.setup({
	auto_preview = true,
})

local rt = {}

require("rust-tools").setup(rt)

-- LSP Diagnostics Options Setup
local sign = function(opts)
	vim.fn.sign_define(opts.name, {
		texthl = opts.name,
		text = opts.text,
		numhl = "",
	})
end

sign({ name = "DiagnosticSignError", text = "" })
sign({ name = "DiagnosticSignWarn", text = "" })
sign({ name = "DiagnosticSignHint", text = "" })
sign({ name = "DiagnosticSignInfo", text = "" })

vim.diagnostic.config({
	virtual_text = false,
	signs = true,
	update_in_insert = true,
	underline = true,
	severity_sort = false,
	float = {
		border = "none",
		source = "always",
		header = "",
		prefix = "",
	},
})

require("config")

-- Completion Plugin Setup
local cmp = require("cmp")
local lspkind = require("lspkind")
cmp.setup({
	-- Enable LSP snippets
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	mapping = {
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),
		-- Add tab support
		["<S-Tab>"] = cmp.mapping.select_prev_item(),
		["<Tab>"] = cmp.mapping.select_next_item(),
		["<C-S-f>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Insert,
			select = true,
		}),
	},
	-- Installed sources:
	sources = {
		{ name = "path" }, -- file paths
		{ name = "nvim_lsp", keyword_length = 3 }, -- from language server
		{ name = "nvim_lsp_signature_help" }, -- display function signatures with current parameter emphasized
		{ name = "nvim_lua", keyword_length = 2 }, -- complete neovim's Lua runtime API such vim.lsp.*
		{ name = "buffer", keyword_length = 2 }, -- source current buffer
		{ name = "vsnip", keyword_length = 2 }, -- nvim-cmp source for vim-vsnip
		{ name = "calc" }, -- source for math calculation
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	formatting = {
		fields = { "menu", "abbr", "kind" },
		format = function(entry, vim_item)
			if vim.tbl_contains({ "path" }, entry.source.name) then
				local icon, hl_group = require("nvim-web-devicons").get_icon(entry:get_completion_item().label)
				if icon then
					vim_item.kind = icon
					vim_item.kind_hl_group = hl_group
					return vim_item
				end
			end
			return lspkind.cmp_format({ with_text = false })(entry, vim_item)
		end,
		--
		--local menu_icon ={
		--    nvim_lsp = 'λ',
		--    vsnip = '⋗',
		--    buffer = 'Ω',
		--    path = '🖫',
		--}
		--item.menu = menu_icon[entry.source.name]
		--return item
		--end,
	},
})

require("mason-lspconfig").setup({
	ensure_installed = {
		"sumneko_lua",
		"clangd",
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
	},
})

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
require("lspconfig").erlangls.setup({})
require("lspconfig").sumneko_lua.setup({
	settings = { Lua = { diagnostics = { globals = { "vim" } } } },
})
require("lspconfig").tsserver.setup({})
require("lspconfig")["pyright"].setup({
	capabilities = capabilities,
})

require("clangd_extensions").setup({
	server = {
		cmd = { "clangd", "--all-scopes-completion=1", "--clang-tidy=1", "--header-insertion=iwyu", "--enable-config" },
	},
})

require("lsp_signature").setup()
-- Treesitter Plugin Setup
require("nvim-treesitter.configs").setup({
	ensure_installed = { "lua", "javascript", "typescript", "php", "rust", "toml", "glsl" },
	auto_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	ident = { enable = true },
	rainbow = {
		enable = true,
		extended_mode = true,
		max_file_lines = nil,
	},
})
