local mappings = require "custom.mappings"

local M = {
    plugins = "custom.plugins",

    mappings = mappings,

    ui = {
        theme = "catppuccin", 
        tabufline = {
            enabled = false,
        },
    },
}

return M
