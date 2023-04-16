return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        virtual_text = { prefix = "", source = "always" },
      },
      servers = {
        bashls = {},
        cmake = {},
        dockerls = {},
        gopls = {},
        gradle_ls = {},
        kotlin_language_server = {},
        ltex = {},
        nil_ls = {
          settings = {
            ["nil"] = {
              formatting = { command = { "nixpkgs-fmt" } },
            },
          },
        },
        ruff_lsp = {},
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              formatting = { command = { "rustfmt" } },
            },
          },
        },
        yamlls = {
          settings = {
            ["yaml"] = {
              schemas = { ["https://json.schemastore.org/github-workflow.json"] = ".github/**/*.yml" },
            },
          },
        },
      },
      setup = {
        clangd = function(_, opts)
          opts.capabilities.offsetEncoding = { "utf-16" }
        end,
      },
    },
  },
  {
    "zbirenbaum/copilot.lua",
    keys = {
      {
        "<leader>cp",
        function()
          require("copilot.suggestion").toggle_auto_trigger()
        end,
        desc = "Copilot suggestion toggle",
      },
    },
  },
}
