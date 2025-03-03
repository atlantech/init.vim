return {
  {
    "olimorris/codecompanion.nvim",
    config = function()
      require("codecompanion").setup({
        strategies = {
          chat = {
            adapter = "openai",
          },
          inline = {
            adapter = "openai",
          },
        },
        adapters = {
          openai = function()
            return require("codecompanion.adapters").extend("openai", {
              env = {
                api_key = "",
              },
              schema = {
                --model = "o3-mini-2025-01-31",
                model = {
                  default = "gpt-4o",
                },
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
