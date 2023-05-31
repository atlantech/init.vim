require "custom/lua/setup"

vim.cmd [[
    nmap <S-F9> <cmd>call vimspector#Launch()<cr>
    nmap <S-F2> <cmd>call vimspector#Reset()<cr>
    nmap <F8> <cmd>call vimspector#StepOver()<cr>
    nmap <F9> <cmd>call vimspector#Continue()<cr>
    nmap <F12> <cmd>call vimspector#StepOut()<cr>")
    nmap <F10> <cmd>call vimspector#StepInto()<cr>")
]]
vim.api.nvim_set_keymap("n", "Db", ":call vimspector#ToggleBreakpoint()<cr>", {})
vim.api.nvim_set_keymap("n", "Dw", ":call vimspector#AddWatch()<cr>", {})
vim.api.nvim_set_keymap("n", "De", ":call vimspector#Evaluate()<cr>", {})

vim.api.nvim_set_keymap("n", "Fzf", ":Files!<cr>", {})
vim.api.nvim_set_keymap("n", "Fzg", ":GFiles!<cr>", {})

vim.api.nvim_set_keymap("n", "Rg", ":Rg!<cr>", {})
vim.api.nvim_set_keymap("n", "Ex", ":Explore<cr>:set number<cr>", {})
vim.api.nvim_set_keymap("n", "Re", ":Rex<cr>:set number<cr>", {})

vim.api.nvim_set_keymap("n", "<c-d>", "<c-d>zz", {})
vim.api.nvim_set_keymap("n", "<c-u>", "<c-u>zz", {})

vim.api.nvim_set_keymap("n", "<Leader>ca", ":lua vim.lsp.buf.code_action()<cr>", {})

vim.g.floaterm_keymap_new = "<Leader>ftn"
vim.g.floaterm_keymap_toggle = "<Leader>ft"

--Set completeopt to have a better completion experience
-- :help completeopt
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not select, force to select one from the menu
-- shortness: avoid showing extra messages when using completion
-- updatetime: set updatetime for CursorHold
vim.opt.completeopt = { "menuone", "noselect", "noinsert" }
vim.opt.shortmess = vim.opt.shortmess + { c = true }
vim.api.nvim_set_option("updatetime", 300)

-- Fixed column for diagnostics to appear
-- Show autodiagnostic popup on cursor hover_range
-- Goto previous / next diagnostic warning / error
-- Show inlay_hints more frequently
vim.cmd [[
    set signcolumn=yes
    autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]]

-- Treesitter folding
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"

-- Vimspector options
vim.cmd [[
    let g:vimspector_sidebar_width = 85
    let g:vimspector_bottombar_height = 15
    let g:vimspector_terminal_maxwidth = 70
    set nocompatible            " disable compatibility to old-time vi
    set showmatch               " show matching
    set encoding=UTF-8
    set ignorecase              " case insensitive
    set mouse=v                 " middle-click paste with
    set hlsearch                " highlight search
    set incsearch               " incremental search
    set tabstop=4               " number of columns occupied by a tab
    set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
    set expandtab               " converts tabs to white space
    set shiftwidth=4            " width for autoindents
    set autoindent              " indent a new line the same amount as the line just typed
    set number                  " add line numbers
    set relativenumber
    set wildmode=longest,list   " get bash-like tab completions
    filetype plugin indent on   "allow auto-indenting depending on file type
    syntax on                   " syntax highlighting
    set mouse=a                 " enable mouse click
    set clipboard=unnamedplus   " using system clipboard
    filetype plugin indent on
    set cursorline              " highlight current cursorline
    set ttyfast                 " Speed up scrolling in Vim
    set updatetime=100
    set shell=zsh
    let g:netrw_localcopydircmd = 'cp -r'
    let g:netrw_winsize = 30
    let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'
    let g:ctrlp_cmd='CtrlPBuffer'
    let g:ctrlp_working_path_mode = 'ra'
    
    let g:fzf_tags_command = 'ctags -R'
    "let g:gutentags_trace=1
    let g:gutentags_ctags_executable='ctags'
    
    let g:rustfmt_autosave = 1
    
    let g:UltiSnipsExpandTrigger='<tab>'
    let g:UltiSnipsListSnippets='<c-tab>'
    let g:UltiSnipsJumpForwardTrigger='<c-j>'
    let g:UltiSnipsJumpBackwardTrigger='<c-k>' 
    let g:neoformat_try_node_exe=1

    autocmd BufWritePre *.{py,lua,js,jsx,ts,tsx} Neoformat
    autocmd BufWritePre *.{m,mm,c,cpp,h,hpp} ClangFormat
]]

vim.g.netrw_keepdir = 1
