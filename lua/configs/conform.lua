local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    rust = { "rustfmt", lsp_format = "fallback" },
    css = { "prettier" },
    html = { "prettier" },
    python = { "black" },
    typescript = { command = "deno fmt", lsp_format = "fallback" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
