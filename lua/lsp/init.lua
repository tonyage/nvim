local constants = require("main.constants")
local config = require("lsp.config")
local lspconfig = require("lspconfig")

for _, server in ipairs(constants.servers) do
  lspconfig[server].setup({
    on_attach = config.on_attach,
    capabilities = config.capabilities,
  })
end

require("lsp.sumneko")
require("lsp.rust")
require("lsp.yamlls")
require("lsp.nix")

