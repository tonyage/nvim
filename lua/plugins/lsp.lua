return {
  { "folke/neodev.nvim", config = true },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "b0o/SchemaStore.nvim",
      version = false,
    },
    opts = {
      inlay_hints = { enable = true },
      diagnostics = {
        virtual_text = { prefix = "icons", source = "always" },
      },
      servers = {
        bashls = {},
        cmake = {},
        cssls = {},
        dartls = {},
        dockerls = {},
        jinja_lsp = {},
        jsonls = {
          on_new_config = function(new_config)
            new_config.settings.json.schemas = new_config.settings.json.schemas or {}
            vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
          end,
          settings = {
            json = {
              format = { enable = true },
              validae = { enable = true },
            },
          },
        },
        lua_ls = {
          setings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
                library = vim.api.nvim_get_runtime_file("", true),
              },
              telemetry = { enable = false },
              completion = { callSnippet = "Replace" },
            },
          },
        },
        html = {},
        ruff_lsp = {},
        pyright = {},
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
              schemas = {
                ["https://json.schemastore.org/github-workflow.json"] = ".github/workflows/*.yml",
                ["https://json.schemastore.org/github-action.json"] = ".github/actions/*.yml",
              },
            },
          },
        },
      },
      setup = {
        clangd = function(_, opts)
          opts.capabilities.offsetEncoding = { "utf-16" }
        end,
        tsserver = function()
          require("lazyvim.util").lsp.on_attach(function(client, buffer)
            if client.name == "tsserver" then
              vim.keymap.set(
                "n",
                "<leader>co",
                "<cmd>TypescriptOrganizeImports<CR>",
                { buffer = buffer, desc = "Organize Imports" }
              )
              vim.keymap.set(
                "n",
                "<leader>cR",
                "<cmd>TypescriptRenameFile<CR>",
                { desc = "Rename File", buffer = buffer }
              )
            end
          end)
        end,
      },
    },
  },
}
