local base_config = require "plugins.configs.telescope"
local options = {
  defaults = {
    layout_config = {
      horizontal = {
        preview_width = 0.55,
        results_width = 0.8,
      },
      width = 0.95,
      height = 0.95,
      preview_cutoff = 120,
    },
  },
}

local config = vim.tbl_deep_extend("force", base_config, options)

return config
