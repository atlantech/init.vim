-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

local mappings = {}

mappings.symbols_outline = {
  n = {
    ["<leader>so"] = {
      function()
        require("symbols-outline").toggle_outline()
      end,
      "Toggle symbols outline",
    },
  },
}

mappings.dap = {
  n = {
    ["<leader>b"] = {
      function()
        return require("dap").toggle_breakpoint()
      end,
      "Toggle breakpoint",
    },
    ["<F5>"] = {
      function()
        return require("dap").continue()
      end,
      "Continue debug",
    },
    ["<F7>"] = {
      function()
        return require("dap").step_into()
      end,
      "Step into",
    },
    ["<F8>"] = {
      function()
        return require("dap").step_over()
      end,
      "Step over",
    },
  },
}

mappings.undotree = {
  n = {
    ["<leader>ut"] = {
      "<cmd> UndotreeToggle <CR>",
      "Toggle undotree",
    },
  },
}

M.base46 = {
  theme = "catppuccin",
  mappings = mappings,

  ui = {
    theme = "catppuccin",
    tabufline = {
      enabled = false,
    },
  },
  -- hl_override = {
  -- 	Comment = { italic = true },
  -- 	["@comment"] = { italic = true },
  -- },
}

M.ui = {
  tabufline = {
    enabled = false,
  },
}

M.mason = {
  pkgs = {
    "c",
    "c_sharp",
    "objc",
    "cpp",
    "css",
    "elixir",
    "erlang",
    "go",
    "gomod",
    "gowork",
    "php",
    "phpdoc",
    "python",
    "ruby",
    "rust",
    "scala",
    "swift",
    "typescript",
    "vim",
    "vimdoc",
    "yaml",
    "zig",
    "hlsl",
    "java",
    "kotlin",
    "llvm",
    "luadoc",
    "make",
    "json",
    "lua",
    "javascript",
    "typescript",
    "php",
    "rust",
    "toml",
    "glsl",
  },
}

return M
