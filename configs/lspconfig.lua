local capabilities = require("plugins.configs.lspconfig").capabilities
local on_attach = require("plugins.configs.lspconfig").on_attach
local lspconfig = require "lspconfig"

-- todo setup each server individually
local servers = {
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
  "ruby_ls",
  "tailwindcss",
  "tsserver",
  "vimls",
  "yamlls",
}

for _, server in ipairs(servers) do
  lspconfig[server].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

lspconfig.rust_analyzer.setup {
  settings = {
    ["rust-analyzer"] = {},
  },
}
