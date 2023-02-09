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
"set cc=80                  " set an 80 column border for good coding style
filetype plugin indent on   "allow auto-indenting depending on file type
syntax on                   " syntax highlighting
set mouse=a                 " enable mouse click
set clipboard=unnamedplus   " using system clipboard
filetype plugin indent on
set cursorline              " highlight current cursorline
set ttyfast                 " Speed up scrolling in Vim
" set spell                 " enable spell check (may need to download language package)
" set noswapfile            " disable creating swap file
" set backupdir=~/.cache/vim " Directory to store backup files.
"
"set t_Co=256
set updatetime=100
set shell=zsh

call plug#begin()
"    Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'itchyny/lightline.vim'
Plug 'sheerun/vim-polyglot'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mfussenegger/nvim-dap'
Plug 'williamboman/mason.nvim'
Plug 'voldikss/vim-floaterm'
" mason deps: pyright, pylint, python-lsp-server, codelldb, rust-analyzer
" clangd, typescript, lua, tailwindcss
" todo add endure_installed = { ... }
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'simrat39/rust-tools.nvim'
Plug 'simrat39/symbols-outline.nvim'
Plug 'p00f/clangd_extensions.nvim'
Plug 'rhysd/vim-clang-format'
Plug 'ludovicchabant/vim-gutentags'
Plug 'ray-x/lsp_signature.nvim'
Plug 'onsails/lspkind.nvim'
Plug 'SirVer/ultisnips'
Plug 'vim-autoformat/vim-autoformat'
Plug 'RRethy/vim-illuminate'
" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/vim-vsnip'

Plug 'puremourning/vimspector'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'sbdchd/neoformat'
" colors
Plug 'arcticicestudio/nord-vim'
Plug 'folke/lsp-colors.nvim'
Plug 'joshdick/onedark.vim'
call plug#end()

"set statusline+=%F
set statusline+=%{gutentags#statusline()}

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
    set termguicolors
endif

"colorscheme onedark
colorscheme nord
let g:airline_theme='nord'
"let g:lightline={ "colorscheme": "nightfox" }

:tnoremap <Esc> <C-\><C-n>
:nnoremap <C-j> gt<CR>
:nnoremap <C-k> gT<CR>

let g:ctrlp_cmd='CtrlPMRUFiles'
let g:ctrlp_working_path_mode = 'ra'

"let g:gutentags_trace=1
let g:gutentags_ctags_executable='ctags'

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'default'

let g:rustfmt_autosave = 1

let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsListSnippets='<c-tab>'
let g:UltiSnipsJumpForwardTrigger='<c-j>'
let g:UltiSnipsJumpBackwardTrigger='<c-k>'



let g:neoformat_try_node_exe=1
autocmd BufWritePre *.{py,lua,js,jsx,ts,tsx} Neoformat
autocmd BufWritePre *.{c,cpp,h,hpp} ClangFormat

:lua << EOF
require("setup")
EOF

