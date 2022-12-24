local config = require("lsp.config")
local lspconfig = require("lspconfig")

lspconfig.rust_analyzer.setup({
  on_attach = config.on_attach,
  capabilities = config.capabilities
})

