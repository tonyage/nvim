return {
  {
    "nvchad/nvim-colorizer.lua",
    opts = { filetypes = { "lua", "css", "nix", "javascript" } },
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local null = require("null-ls")

      table.insert(opts.sources, null.builtins.hover.dictionary)
      table.insert(opts.sources, null.builtins.hover.printenv)

      table.insert(
        opts.sources,
        null.builtins.code_actions.gitsigns.with({
          config = {
            filter_actions = function(title)
              return title:lower():match("blame") == nil
            end,
          },
        })
      )

      table.insert(opts.sources, null.builtins.formatting.cmake_format)
      table.insert(opts.sources, null.builtins.diagnostics.cmake_lint)

      table.insert(opts.sources, null.builtins.formatting.prettierd)

      table.insert(opts.sources, null.builtins.diagnostics.deadnix)
      table.insert(opts.sources, null.builtins.code_actions.statix)

      table.insert(
        opts.sources,
        null.builtins.formatting.shfmt.with({
          extra_args = { "-i", 2, "-s", "-w" },
        })
      )
      table.insert(opts.sources, null.builtins.code_actions.shellcheck)

      table.insert(opts.sources, null.builtins.code_actions.refactoring)

      table.insert(opts.sources, null.builtins.formatting.buf)
      table.insert(opts.sources, null.builtins.diagnostics.buf)

      table.insert(opts.sources, null.builtins.formatting.ruff)
      table.insert(opts.sources, null.builtins.diagnostics.ruff)

      table.insert(opts.sources, null.builtins.formatting.markdownlint)
      table.insert(opts.sources, null.builtins.diagnostics.markdownlint)

      table.insert(opts.sources, require("typescript.extensions.null-ls.code-actions"))

      table.insert(opts.sources, null.builtins.formatting.yamlfmt)
      table.insert(opts.sources, null.builtins.diagnostics.yamllint)

      table.insert(opts.sources, null.builtins.diagnostics.zsh)
    end,
  },
  {
    "bennypowers/splitjoin.nvim",
    lazy = true,
    keys = {
      {
        "gj",
        function()
          require("splitjoin").join()
        end,
        desc = "Join the object under the cursor",
      },
      {
        "g,",
        function()
          require("splitjoin").split()
        end,
        desc = "Split the object under the cursor",
      },
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "VeryLazy",
    opts = {
      show_end_of_line = true,
      show_first_indent_level = false,
    },
  },
  {
    "uga-rosa/ugaterm.nvim",
    lazy = false,
    opts = {
      prefix = "local",
      filetype = "ugaterm",
      open_cmd = "botright 15sp",
    },
  },
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
          "dart",
          "json5",
          "jsonc",
          "kotlin",
          "make",
          "ninja",
          "nix",
          "rust",
          "scss",
        })
      end
    end,
    context_commentstring = { enable = true },
  },
}
