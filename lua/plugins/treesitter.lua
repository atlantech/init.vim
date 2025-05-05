vim.filetype.add({
  pattern = {
    ["rebar%.config"] = "erlang",
  },
})

return {
  {

    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "c",
        "c_sharp",
        "objc",
        "cpp",
        "css",
        "elixir",
        "erlang",
        "go",
        "gomod",
        "gowork",
        "php",
        "phpdoc",
        "python",
        "ruby",
        "rust",
        "scala",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
        "zig",
        "hlsl",
        "java",
        "kotlin",
        "llvm",
        "luadoc",
        "make",
        "json",
        "lua",
        "javascript",
        "typescript",
        "php",
        "rust",
        "toml",
        "glsl",
      },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = {},
        use_languagetree = true,
      },
      ident = { enable = true },
      rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil,
      },
    },
  },
  { "nvim-treesitter/nvim-treesitter-context", lazy = false },
}
