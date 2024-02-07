local mappings = require "custom.mappings"

local M = {
    plugins = "custom.plugins",

    mappings = mappings,

    ui = {
        tabufline = {
            enabled = false,
        },
    },
}

return M
