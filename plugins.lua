local plugins = {
    "nvim-lua/plenary.nvim",

    {
        "jose-elias-alvarez/null-ls.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },

        lazy = false,
        config = function()
            local null_ls = require "null-ls"
            local formatting = null_ls.builtins.formatting
            local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
            local opt = {
                sources = {
                    formatting.gofmt,
                    formatting.goimports,
                    formatting.golines,
                    formatting.ktlint,
                    formatting.nginx_beautifier,
                    formatting.phpcbf,
          formatting.phpcs,
                    formatting.prettier,
                    formatting.cmake_format,
                    formatting.csharpier,
                    formatting.erlfmt.with {
                        command = "rebar3",
                        args = { "fmt", "-" },
                    },
                    formatting.eslint,
                    formatting.json_tool,
                    formatting.rustfmt,
                    formatting.stylelint,
                    formatting.swiftlint,
                    formatting.tidy,
                    -- formatting.yamlfix,
                    formatting.zigfmt,
                    formatting.stylua,
                    formatting.autopep8,
                    formatting.clang_format.with {
                        extra_filetypes = { "m", "mm" },
                    },
                    null_ls.builtins.diagnostics.phpcs.with {
                        args = {
                            "--standard=PSR12",
                        },
                    },
                    null_ls.builtins.formatting.phpcbf.with {
                        args = {
                            "--standard=PSR12",
                        },
                    },
                },
                on_attach = function(client, bufnr)
                    if client.supports_method "textDocument/formatting" then
                        vim.api.nvim_clear_autocmds {
                            group = augroup,
                            buffer = bufnr,
                        }
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            group = augroup,
                            buffer = bufnr,
                            callback = function()
                                vim.lsp.buf.format { bufnr = bufnr }
                            end,
                        })
                    end
                end,
            }

            null_ls.setup(opt)
        end,
    },

    "junegunn/fzf",
    "junegunn/fzf.vim",

    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build =
        "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
    },

    {
        "nvim-telescope/telescope.nvim",
        opts = {
            extensions_list = {
                "fzf",
            },
        },
    },

    "ryanoasis/vim-devicons",
    "sheerun/vim-polyglot",

    {
        "mfussenegger/nvim-dap",
        init = function()
            require("core.utils").load_mappings "dap"

            local dap = require "dap"

            -- todo remove hardcoded path
            dap.adapters.lldb = {
                id = "lldb",
                type = "executable",
                command = "lldb-vscode",
            }

            dap.adapters.cppdbg = {
                id = "cppdbg",
                type = "executable",
                command = "OpenDebugAD7",
            }

            dap.adapters.els_dap = {
                id = "els_dap",
                type = "executable",
                command = "els_dap",
            }

            dap.configurations.erlang = {
                {
                    name = "Existing Erlang Node",
                    type = "els_dap",
                    request = "attach",
                    projectnode = "hello_world_example",
                    cookie = "hello_world_example",
                    cwd = "${workspaceRoot}",
                },
            }

            dap.configurations.cpp = {
                {
                    name = "Launch file",
                    type = "lldb",
                    request = "launch",
                    program = function()
                        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                    end,
                    cwd = "${workspaceFolder}",
                    runInTerminal = false,
                    args = {},
                },
            }
            dap.configurations.c = dap.configurations.cpp
            dap.configurations.rust = dap.configurations.rust
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        opts = function()
            return require "custom.configs.telescope"
        end,
    },
    "voldikss/vim-floaterm",

    {
        "williamboman/mason.nvim",
        opts = function()
            local default_conf = require "plugins.configs.mason"
            local custom = require "custom.configs.mason"

            return vim.tbl_deep_extend("force", default_conf, custom)
        end,
    },

    "williamboman/mason-lspconfig.nvim",

    {
        "nvim-treesitter/nvim-treesitter",
        opts = function()
            local default = require "plugins.configs.treesitter"
            local custom = require "custom.configs.treesitter"

            return vim.tbl_deep_extend("force", default, custom)
        end,
    },

    { "nvim-treesitter/nvim-treesitter-context", lazy = false },

    {
        "neovim/nvim-lspconfig",
        config = function()
            require "plugins.configs.lspconfig"
            require "custom.configs.lspconfig"
        end,
    },

    {
        "simrat39/rust-tools.nvim",
        config = function()
            require("rust-tools").setup {}
        end,
    },

    {
        "simrat39/symbols-outline.nvim",
        lazy = false,
        config = function()
            local symbols_outline = require "symbols-outline"
            symbols_outline.setup {
                show_guides = true,
                auto_preview = true,
            }
        end,
    },

    "p00f/clangd_extensions.nvim",
    "ludovicchabant/vim-gutentags",

    {
        "ray-x/lsp_signature.nvim",
        config = function()
            require("lsp_signature").setup()
        end,
    },

    { "onsails/lspkind.nvim",                    lazy = false },

    "SirVer/ultisnips",
    "RRethy/vim-illuminate",
    "honza/vim-snippets",
    "airblade/vim-gitgutter",

    { "tpope/vim-fugitive",      lazy = false },

    "christoomey/vim-tmux-navigator",
    "tpope/vim-obsession",

    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-vsnip",
            "hrsh7th/vim-vsnip",
        },
        config = function()
            local cmp = require "cmp"
            local lspkind = require "lspkind"

            cmp.setup {
                -- Enable LSP snippets
                snippet = {
                    expand = function(args)
                        vim.fn["vsnip#anonymous"](args.body)
                    end,
                },
                mapping = {
                    ["<C-p>"] = cmp.mapping.select_prev_item(),
                    ["<C-n>"] = cmp.mapping.select_next_item(),
                    -- Add tab support
                    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
                    ["<Tab>"] = cmp.mapping.select_next_item(),
                    ["<C-S-f>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.close(),
                    ["<CR>"] = cmp.mapping.confirm {
                        behavior = cmp.ConfirmBehavior.Insert,
                        select = true,
                    },
                },
                -- Installed sources:
                sources = {
                    { name = "path" },               -- file paths
                    { name = "nvim_lsp",               keyword_length = 3 }, -- from language server
                    { name = "nvim_lsp_signature_help" }, -- display function signatures with current parameter emphasized
                    { name = "nvim_lua",               keyword_length = 2 }, -- complete neovim"s Lua runtime API such vim.lsp.*
                    { name = "buffer",                 keyword_length = 2 }, -- source current buffer
                    { name = "vsnip",                  keyword_length = 2 }, -- nvim-cmp source for vim-vsnip
                    { name = "calc" },               -- source for math calculation
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                formatting = {
                    fields = { "menu", "abbr", "kind" },
                    format = function(entry, vim_item)
                        if vim.tbl_contains({ "path" }, entry.source.name) then
                            local icon, hl_group = require("nvim-web-devicons").get_icon(entry:get_completion_item()
                            .label)
                            if icon then
                                vim_item.kind = icon
                                vim_item.kind_hl_group = hl_group
                                return vim_item
                            end
                        end
                        return lspkind.cmp_format { with_text = false } (entry, vim_item)
                    end,
                    --
                    --local menu_icon ={
                    --    nvim_lsp = "λ",
                    --    vsnip = "⋗",
                    --    buffer = "Ω",
                    --    path = "🖫",
                    --}
                    --item.menu = menu_icon[entry.source.name]
                    --return item
                    --end,
                },
            }
        end,
    },

    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-buffer",

  "folke/lsp-colors.nvim",

    { "catppuccin/nvim", name = "catppuccin" },

    "beanworks/vim-phpfmt",

    { "ziglang/zig.vim", lazy = false },

    {
        "leoluz/nvim-dap-go",
        init = function()
            local opts = {
                dap_configurations = {
                    {
                        type = "go",
                        name = "Attach remote",
                        request = "launch",
                        program = "${file}",
                    },
                },
                delve = {
                    path = "dlv",
                    initialize_timeout_sec = 20,
                    port = "${port}",
                    args = {},
                },
            }
            require("dap-go").setup(opts)
        end,
    },

    {
        "rcarriga/nvim-dap-ui",
        lazy = false,
        dependencies = {
            "mfussenegger/nvim-dap",
        },
        init = function()
            require "custom.configs.dapui"
        end,
    },

    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap" },
        config = function()
            local opts = {
                library = { plugins = { "nvim-dap-ui" }, type = true },
            }
            return opts
        end,
    },
    { "mbbill/undotree", lazy = false },
    {
        "nvim-tree/nvim-tree.lua",
        cmd = { "NvimTreeToggle", "NvimTreeFocus" },
        init = function()
            require("core.utils").load_mappings "nvimtree"
        end,
        opts = function()
            local custom = require "custom.configs.nvimtree"
            local default = require "plugins.configs.nvimtree"

            return vim.tbl_deep_extend("force", default, custom)
        end,
        config = function(_, opts)
            dofile(vim.g.base46_cache .. "nvimtree")
            require("nvim-tree").setup(opts)
        end,
    },
}

return plugins
