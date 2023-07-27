-- todo replace null-ls with something
local config = {
  "jose-elias-alvarez/null-ls.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },

  lazy = false,
  config = function()
    local null_ls = require "null-ls"
    local formatting = null_ls.builtins.formatting
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
    local opt = {
      sources = {
        formatting.gofmt,
        formatting.goimports,
        formatting.ktlint,
        formatting.nginx_beautifier,
        formatting.phpcbf,
        formatting.phpcsfixer,
        formatting.prettier,
        formatting.cmake_format,
        formatting.csharpier,
        formatting.erlfmt.with {
          command = "rebar3",
          args = { "fmt", "-" },
        },
        formatting.eslint,
        formatting.json_tool,
        formatting.mix,
        formatting.rubocop,
        formatting.rubyfmt,
        formatting.rustfmt,
        formatting.rustywind,
        formatting.stylelint,
        formatting.swiftlint,
        formatting.tidy,
        formatting.yamlfix,
        formatting.zigfmt,
        formatting.stylua,
        formatting.autopep8,
        formatting.clang_format.with {
          extra_filetypes = { "m", "mm" },
        },
      },
      on_attach = function(client, bufnr)
        if client.supports_method "textDocument/formatting" then
          vim.api.nvim_clear_autocmds {
            group = augroup,
            buffer = bufnr,
          }
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format { bufnr = bufnr }
            end,
          })
        end
      end,
    }

    null_ls.setup(opt)
  end,
}
