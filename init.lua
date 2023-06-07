vim.api.nvim_set_keymap("n", "<Leader>ca", ":lua vim.lsp.buf.code_action()<cr>", {})

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
    
    let g:fzf_tags_command = 'ctags -R'
    "let g:gutentags_trace=1
    let g:gutentags_ctags_executable='ctags'
    
    let g:rustfmt_autosave = 1
    
    let g:UltiSnipsExpandTrigger='<tab>'
    let g:UltiSnipsListSnippets='<c-tab>'
    let g:UltiSnipsJumpForwardTrigger='<c-j>'
    let g:UltiSnipsJumpBackwardTrigger='<c-k>' 
]]
