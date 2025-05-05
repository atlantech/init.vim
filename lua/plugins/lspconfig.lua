return {
  {
    "neovim/nvim-lspconfig",
    opts = function()
      local ret = {

        inlay_hints = {
          enable = true,
        },
        diagnostics = {
          virtual_text = {
            prefix = "●",
            spacing = 4,
          },
          signs = true,
          underline = true,
          severity_sort = true,
          update_in_insert = false,
          severity = { min = vim.diagnostic.severity.HINT },
        },
      }
      return ret
    end,
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
        --"gopls",
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
              unhandledErrors = true,
              unusedparams = true,
            },
            staticcheck = true,
          },
        },
      })

      local configs = require("lspconfig/configs")
      if not configs.golangcilsp then
        configs.golangcilsp = {
          default_config = {
            cmd = { "golangci-lint-langserver" },
            root_dir = lspconfig.util.root_pattern(".git", "go.mod"),
            init_options = {
              command = { "golangci-lint", "run", "--out-format", "json", "--issues-exit-code=1" },
            },
          },
        }
      end
      --lspconfig.golangci_lint_ls.setup({
      -- filetypes = { "go", "gomod" },
      --})

      lspconfig.denols.setup({
        root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
      })
    end,
  },
}
