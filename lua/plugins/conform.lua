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
      },

      default_format_opts = {
        lsp_format = "fallback",
      },
    },
  },
}
