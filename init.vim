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
    Plug 'sheerun/vim-polyglot'
    Plug 'ctrlpvim/ctrlp.vim'
    Plug 'mfussenegger/nvim-dap'
    Plug 'williamboman/mason.nvim'
    " mason deps: pyright, pylint, python-lsp-server, codelldb, rust-analyzer
    " clangd
    Plug 'williamboman/mason-lspconfig.nvim'
    Plug 'neovim/nvim-lspconfig'
    Plug 'simrat39/rust-tools.nvim'
    Plug 'p00f/clangd_extensions.nvim'
    Plug 'rhysd/vim-clang-format'
    Plug 'ludovicchabant/vim-gutentags'
    Plug 'ray-x/lsp_signature.nvim'
    Plug 'onsails/lspkind.nvim'
    Plug 'SirVer/ultisnips'
    " Snippets are separated from the engine. Add this if you want them:
    Plug 'honza/vim-snippets'
    Plug 'airblade/vim-gitgutter'
    Plug 'liuchengxu/vista.vim'

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
    " Plug 'arcticicestudio/nord-vim'
    Plug 'folke/lsp-colors.nvim'
    "Plug 'sonph/onehalf', { 'rtp': 'vim' }
    Plug 'joshdick/onedark.vim'
call plug#end()

set statusline+=%{gutentags#statusline()}

if has("termguicolors")
    set termguicolors
endif

colorscheme onedark 
let g:airline_theme='onedark'

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
autocmd BufWritePre *.{js,jsx,ts,tsx} Neoformat

:lua << EOF
require("mason").setup()

local rt = {
    server = {
        settings = {
            on_attach = function(_, bufnr)
                -- Hover actions
                vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
                -- Code action groups
                vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
                require 'illuminate'.on_attach(client)
            end,
            ["rust-analyzer"] = {
                checkOnSave = {
                    command = "clippy"
                }, 
            },
        }
    },
}

require('rust-tools').setup(rt)

-- LSP Diagnostics Options Setup 
local sign = function(opts)
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = ''
  })
end

sign({name = 'DiagnosticSignError', text = ''})
sign({name = 'DiagnosticSignWarn', text = ''})
sign({name = 'DiagnosticSignHint', text = ''})
sign({name = 'DiagnosticSignInfo', text = ''})

vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    update_in_insert = true,
    underline = true,
    severity_sort = false,
    float = {
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
    },
})

require("config")

-- Completion Plugin Setup
local cmp = require'cmp'
local lspkind = require'lspkind'
cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-S-f>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },
  -- Installed sources:
  sources = {
    { name = 'path' },                              -- file paths
    { name = 'nvim_lsp', keyword_length = 3 },      -- from language server
    { name = 'nvim_lsp_signature_help'},            -- display function signatures with current parameter emphasized
    { name = 'nvim_lua', keyword_length = 2},       -- complete neovim's Lua runtime API such vim.lsp.*
    { name = 'buffer', keyword_length = 2 },        -- source current buffer
    { name = 'vsnip', keyword_length = 2 },         -- nvim-cmp source for vim-vsnip 
    { name = 'calc'},                               -- source for math calculation
  },
  window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
  },
  formatting = {
      fields = {'menu', 'abbr', 'kind'},
      format = lspkind.cmp_format({
          mode = 'symbol', -- show only symbol annotations
          maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
          ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

          -- The function below will be called before any actual modifications from lspkind
          -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
          before = function (entry, vim_item) 
            return vim_item
          end
      }) 
          --local menu_icon ={
          --    nvim_lsp = 'λ',
          --    vsnip = '⋗',
          --    buffer = 'Ω',
          --    path = '🖫',
          --}
          --item.menu = menu_icon[entry.source.name]
          --return item
      --end,
  },
})

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
require('lspconfig')['pyright'].setup {
    capabilities = capabilities
}

require('clangd_extensions').setup({
    server = {
        cmd =  { "clangd", "--all-scopes-completion=1", "--clang-tidy=1", "--header-insertion=iwyu", "--enable-config" }
    }
})

require("lsp_signature").setup()
-- Treesitter Plugin Setup 
require('nvim-treesitter.configs').setup {
    ensure_installed = {"lua", "rust", "toml", "glsl"}, auto_install = true,
    highlight =
        {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
    ident = {enable = true}, rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil,
    }
}

EOF

