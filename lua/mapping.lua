-- Vimspector
vim.cmd([[
    nmap <S-F9> <cmd>call vimspector#Launch()<cr>
    nmap <S-F2> <cmd>call vimspector#Reset()<cr>
    nmap <F8> <cmd>call vimspector#StepOver()<cr>
    nmap <F9> <cmd>call vimspector#Continue()<cr>
    nmap <F12> <cmd>call vimspector#StepOut()<cr>")
    nmap <F10> <cmd>call vimspector#StepInto()<cr>")
]])
vim.api.nvim_set_keymap('n', "Db", ":call vimspector#ToggleBreakpoint()<cr>", {})
vim.api.nvim_set_keymap('n', "Dw", ":call vimspector#AddWatch()<cr>", {})
vim.api.nvim_set_keymap('n', "De", ":call vimspector#Evaluate()<cr>", {})

vim.api.nvim_set_keymap('n', "Fz", ":Files<cr>", {})
vim.api.nvim_set_keymap('n', "Rg", ":Rg<cr>", {})
vim.api.nvim_set_keymap('n', "Ex", ":Explore<cr>", {})
vim.api.nvim_set_keymap('n', "Re", ":Rex<cr>", {})
