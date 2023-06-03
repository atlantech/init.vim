local plugins = {
  "nvim-lua/plenary.nvim",
  {
    "junegunn/fzf",
  },
  "junegunn/fzf.vim",
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
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
  "mfussenegger/nvim-dap",
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

    config = function()
      local symbols_outline = require "symbols-outline"
      symbols_outline.setup {
        auto_preview = true,
      }
    end,
  },
  "p00f/clangd_extensions.nvim",
  "rhysd/vim-clang-format",
  "ludovicchabant/vim-gutentags",
  {
    "ray-x/lsp_signature.nvim",
    config = function()
      require("lsp_signature").setup()
    end,
  },
  { "onsails/lspkind.nvim", lazy = false },
  "SirVer/ultisnips",
  "vim-autoformat/vim-autoformat",
  "RRethy/vim-illuminate",
  "honza/vim-snippets",
  "airblade/vim-gitgutter",
  { "tpope/vim-fugitive", lazy = false },
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
          { name = "path" }, -- file paths
          { name = "nvim_lsp", keyword_length = 3 }, -- from language server
          { name = "nvim_lsp_signature_help" }, -- display function signatures with current parameter emphasized
          { name = "nvim_lua", keyword_length = 2 }, -- complete neovim"s Lua runtime API such vim.lsp.*
          { name = "buffer", keyword_length = 2 }, -- source current buffer
          { name = "vsnip", keyword_length = 2 }, -- nvim-cmp source for vim-vsnip
          { name = "calc" }, -- source for math calculation
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        formatting = {
          fields = { "menu", "abbr", "kind" },
          format = function(entry, vim_item)
            if vim.tbl_contains({ "path" }, entry.source.name) then
              local icon, hl_group = require("nvim-web-devicons").get_icon(entry:get_completion_item().label)
              if icon then
                vim_item.kind = icon
                vim_item.kind_hl_group = hl_group
                return vim_item
              end
            end
            return lspkind.cmp_format { with_text = false }(entry, vim_item)
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
  "puremourning/vimspector",
  { "sbdchd/neoformat", lazy = false },
  "folke/lsp-colors.nvim",
  { "catppuccin/nvim", name = "catppuccin" },
  "beanworks/vim-phpfmt",
  { "ziglang/zig.vim", lazy = false },
}

return plugins
