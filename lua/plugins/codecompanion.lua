return {
  {
    "olimorris/codecompanion.nvim",
    config = function()
      require("codecompanion").setup({
        opts = {
          log_level = "DEBU",
        },
        strategies = {
          chat = {
            adapter = "ollama",
          },
          inline = {
            adapter = "ollama",
          },
        },
        adapters = {
          ollama = function()
            return require("codecompanion.adapters").extend("ollama", {
              env = {
                url = "http://192.168.50.177:11434",
              },
            })
          end,
        },
        keymaps = {
          chat = "<leader>cc",
          accept = "<C-J>",
          next = "<C-]>",
          prev = "<C-[>",
        },
      })
    end,
  },
}
