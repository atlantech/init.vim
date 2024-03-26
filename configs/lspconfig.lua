local capabilities = require("plugins.configs.lspconfig").capabilities
local on_attach = require("plugins.configs.lspconfig").on_attach
local lspconfig = require "lspconfig"
local util = require "lspconfig/util"

-- todo setup each server individually
local servers = {
  "rust_analyzer",
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
  --  "docker_compose_language_service",
  "dockerls",
  "elixirls",
  "erlangls",
  "gopls",
  "gradle_ls",
  "jsonls",
  "kotlin_language_server",
  "phpactor",
  -- "tailwindcss",
  "tsserver",
  "vimls",
  -- "yamlls",
}

for _, server in ipairs(servers) do
  lspconfig[server].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

lspconfig.dartls.setup {
  cmd = { "dart", "language-server", "--protocol=lsp" },
}

lspconfig.rust_analyzer.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    ["rust-analyzer"] = {
      imports = {
        granularity = {
          group = "module",
        },
        prefix = "self",
      },
      cargo = {
        buildScript = {
          enable = true,
        },
      },
      procMacro = {
        enable = true,
      },
    },
  },
}

lspconfig.tailwindcss.setup {
  filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "html" },
}

lspconfig.gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
      },
    },
  },
}
