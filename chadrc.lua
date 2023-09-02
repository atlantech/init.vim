local mappings = require "custom.mappings"

local M = {
  plugins = "custom.plugins",

  mappings = mappings,

  ui = {
    theme = "github_light",
    tabufline = {
      enabled = false,
    },
  },
}

return M
