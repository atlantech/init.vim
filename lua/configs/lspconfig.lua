-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"
local servers = {
  "rust_analyzer",
  "pyright",
  "phpactor",
  "zls",
  "ansiblels",
  "bashls",
  "clangd",
  "cmake",
  "csharp_ls",
  "html",
  "cssls",
  "dockerls",
  "elixirls",
  "erlangls",
  "gopls",
  "gradle_ls",
  "jsonls",
  "kotlin_language_server",
  -- "tailwindcss",
  "ts_ls",
  "vimls",
  -- "yamlls",
}
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

local util = require "lspconfig/util"

lspconfig.dartls.setup {
  cmd = { "dart", "language-server", "--protocol=lsp" },
}

lspconfig.rust_analyzer.setup {
  on_attach = nvlsp.on_attach,
  capabilities = nvlsp.capabilities,
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
  on_attach = nvlsp.on_attach,
  capabilities = nvlsp.capabilities,
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
