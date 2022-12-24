local colors = require("ui.themer").colorscheme("vivid")
return {
  LspReferenceText = { fg = colors.black, bg = colors.white },
  LspReferenceRead = { fg = colors.black, bg = colors.white },
  LspReferenceWrite = { fg = colors.black, bg = colors.white },

  -- Lsp Diagnostics
  DiagnosticHint = { fg = colors.magenta },
  DiagnosticError = { fg = colors.red },
  DiagnosticWarn = { fg = colors.yellow },
  DiagnosticInformation = { fg = colors.green },
  LspSignatureActiveParameter = { fg = colors.black, bg = colors.orange },

  RenamerTitle = { fg = colors.black, bg = colors.red },
  RenamerBorder = { fg = colors.red },
}
