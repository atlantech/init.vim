local capabilities = require("plugins.configs.lspconfig").capabilities
local on_attach = require("plugins.configs.lspconfig").on_attach
local lspconfig = require "lspconfig"

-- todo setup each server individually
local servers = {
  "erlangls",
  "tsserver",
  "pyright",
  "phpactor",
  "zls",
  "ansiblels",
  "bashls",
  "clangd",
  "cmake",
  "csharp_ls",
  "cssls",
  "docker_compose_language_service",
  "dockerls",
  "elixirls",
  "erlangls",
  "gopls",
  "gradle_ls",
  "jsonls",
  "kotlin_language_server",
  "phpactor",
  "ruby_lsp",
  "tailwindcss",
  "tsserver",
  "vimls",
  "yamlls",
}

lspconfig.rust_analyzer.setup {
  settings = {
    ["rust-analyzer"] = {},
  },
}

for _, server in ipairs(servers) do
  lspconfig[server] = {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end
