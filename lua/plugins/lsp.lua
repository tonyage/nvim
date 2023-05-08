return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "b0o/SchemaStore.nvim",
      version = false,
    },
    opts = {
      diagnostics = {
        virtual_text = { prefix = "", source = "always" },
      },
      servers = {
        bashls = {},
        cmake = {},
        dockerls = {},
        gradle_ls = {},
        jsonls = {
          on_new_config = function(new_config)
            new_config.settings.json.schemas = new_config.settings.json.schemas or {}
            vim.list_extend(new_config.settings.json.schemas, reuire("schemastore").json.schemas())
          end,
          settings = {
            json = {
              format = { enable = true },
              validae = { enable = true },
            },
          },
        },
        kotlin_language_server = {},
        lua_ls = {
          setings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
                library = {
                  [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                  [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                },
              },
              completion = { callSnippet = "Replace" },
            },
          },
        },
        ltex = {},
        nil_ls = {
          settings = {
            ["nil"] = {
              formatting = { command = { "nixpkgs-fmt" } },
            },
          },
        },
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
        tsserver = function(_, opts)
          require("lazyvim.util").on_attach(function(client, buffer)
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
          require("typescript").setup({ server = opts })
          return true
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
