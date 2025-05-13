return {
  { "echasnovski/mini.splitjoin", version = "*" },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
      current_line_blame_opts = { delay = 150 },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    opts = {
      ensured_installed = {
        "c",
        "cmake",
        "css",
        "dart",
        "go",
        "json5",
        "jsonc",
        "kotlin",
        "make",
        "ninja",
        "nix",
        "rust",
        "ron",
        "scss",
        "sql",
      },
    },
    context_commentstring = { enable = true },
  },
  {
    "lervag/vimtex",
    lazy = false,
    init = function()
      vim.g.vimtex_view_general_viewer = "open"
      vim.g.vimtex_view_general_options = "-a Preview"
      vim.g.vimtext_compiler_method = "tectonic"
    end,
  },
}
