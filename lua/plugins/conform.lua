return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        erlang = { "erlfmt" },
        go = { "goimports", "gofmt" },
        rust = { "rustfmt", lsp_format = "fallback" },
        css = { "prettier" },
        html = { "prettier" },
        python = { "black" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        yaml = { "prettier" },
        sql = { "sleek" },
        dart = { "dart" },
      },

      default_format_opts = {
        lsp_format = "fallback",
      },

      formatters = {
        dart = {
          command = "dart",
          args = { "format", "-o", "show", "--show", "none", "--summary", "none", "$FILENAME" },
        },
      },
    },
  },
}
