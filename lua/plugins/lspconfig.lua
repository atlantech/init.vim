return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      local servers = {
        "lua_ls",

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
        "tailwindcss",
        "ts_ls",
        "vimls",
        -- "yamlls",
        "denols",
      }

      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup({})
      end

      local util = require("lspconfig/util")

      lspconfig.dartls.setup({
        cmd = { "dart", "language-server", "--protocol=lsp" },
      })

      lspconfig.rust_analyzer.setup({
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
      })

      lspconfig.tailwindcss.setup({
        filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "html" },
      })

      lspconfig.gopls.setup({
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
      })

      lspconfig.denols.setup({
        root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
      })
    end,
  },
}
