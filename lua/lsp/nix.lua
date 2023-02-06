local config = require("lsp.config")
local lspconfig = require("lspconfig")
print(vim.inspect(vim.env.NIL_PATH))

lspconfig.nil_ls.setup({
  autostart = true,
  on_attach = config.on_attach,
  capabilities = config.capabilities,
  settings= {
    ["nil"] = {
      formatting = {
        command = { "nixpkgs-fmt" }
      }
    }
  }
})
