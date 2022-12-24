local lspconfig = require("lspconfig")
local config = require("lsp.config")

lspconfig.yamlls.setup({
  on_attach = config.on_attach,
  settings = {
    yaml = {
      schemes = {
        ["https://json.schemasstore.org/github-workflow.json"] = "/.github/workflow/*"
      }
    }
  },
})
