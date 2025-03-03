-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local builtin = require("telescope.builtin")
local utils = require("telescope.utils")

vim.keymap.set("n", "<leader>fw", "<cmd>Telescope live_grep<cr>", { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fW", function()
  builtin.live_grep({
    cwd = utils.buffer_dir(),
  })
end, { desc = "Telescope live grep (CWD)" })
vim.keymap.set(
  "n",
  "<leader>fz",
  "<cmd>Telescope current_buffer_fuzzy_find<cr>",
  { desc = "Telescope find in current buffer" }
)

vim.keymap.set(
  "n",
  "<leader>fa",
  "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<cr>",
  { desc = "Telescope find all" }
)

vim.keymap.set(
  "n",
  "<leader>fd",
  "<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>",
  { desc = "Telescope file browser" }
)

vim.keymap.set("n", "<leader>ra", vim.lsp.buf.rename, { desc = "Rename symbol" })

vim.keymap.set("n", "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", { desc = "Toggle CodeCompanionChat" })
