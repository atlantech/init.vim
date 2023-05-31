
-- LSP Diagnostics Options Setup
local sign = function(opts)
	vim.fn.sign_define(opts.name, {
		texthl = opts.name,
		text = opts.text,
		numhl = "",
	})
end

--sign({ name = "DiagnosticSignError", text = "" })
--sign({ name = "DiagnosticSignWarn", text = "" })
--sign({ name = "DiagnosticSignHint", text = "" })
--sign({ name = "DiagnosticSignInfo", text = "" })

--vim.diagnostic.config({
--	virtual_text = false,
--	signs = true,
--	update_in_insert = true,
--	underline = true,
--	severity_sort = false,
--	float = {
--		border = "none",
--		source = "always",
--		header = "",
--		prefix = "",
--	},
--})

-- require("config")

--require("clangd_extensions").setup({
--	server = {
--		cmd = { "clangd", "--all-scopes-completion=1", "--clang-tidy=1", "--header-insertion=iwyu", "--enable-config" },
--	},
--})


