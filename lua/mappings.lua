require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

vim.api.nvim_set_keymap("n", "<Leader>ca", ":lua vim.lsp.buf.code_action()<cr>", {})
vim.api.nvim_set_keymap("n", "<Leader>ft", ":lua require'telescope.builtin'.treesitter {}<cr>", {})

vim.api.nvim_del_keymap("n", "<tab>")
