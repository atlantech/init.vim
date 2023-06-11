local M = {}

M.dap = {
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

M.undotree = {
  n = {
    ["<leader>ut"] = {
      "<cmd> UndotreeToggle <CR>",
      "Toggle undotree",
    },
  },
}
return M
