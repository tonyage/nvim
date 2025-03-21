return {
  {
    "nvchad/nvim-colorizer.lua",
    opts = { filetypes = { "lua", "css", "nix", "javascript", "json" } },
  },
  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      local null = require("null-ls")
      local code_actions = null.builtins.code_actions
      local diagnostics = null.builtins.diagnostics
      local formatting = null.builtins.formatting
      local hover = null.builtins.hover

      opts.sources = vim.list_extend(opts.sources or {}, {
        code_actions.gitsigns.with({
          config = {
            filter_actions = function(title)
              return title:lower():match("blame") == nil
            end,
          },
        }),
        code_actions.refactoring,
        code_actions.statix,
        diagnostics.markdownlint,
        diagnostics.yamllint,
        diagnostics.zsh,
        formatting.treefmt,
        hover.dictionary,
        hover.printenv,
      })
    end,
  },
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
    opts = function(_, opts)
      if type(opts.ensured_installed) == "table" then
        vim.list_extend(opts.ensured_installed, {
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
          "scss",
          "sql",
        })
      end
    end,
    context_commentstring = { enable = true },
  },
}
