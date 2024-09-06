local cmp = require "cmp"
local lspkind = require "lspkind"

local empty = {}
local config = {
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
    { name = "path" },                         -- file paths
    { name = "nvim_lsp",               keyword_length = 3 }, -- from language server
    { name = "nvim_lsp_signature_help" },      -- display function signatures with current parameter emphasized
    { name = "nvim_lua",               keyword_length = 2 }, -- complete neovim"s Lua runtime API such vim.lsp.*
    { name = "buffer",                 keyword_length = 2 }, -- source current buffer
    { name = "vsnip",                  keyword_length = 2 }, -- nvim-cmp source for vim-vsnip
    { name = "calc" },                         -- source for math calculation
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

return empty
