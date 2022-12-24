local colors = require("ui.themer").colorscheme("vivid")
local statusline_bg = colors.base01

return {
  StatusLine = { bg = statusline_bg },

  git_branch = { fg = colors.white, bg = colors.base02, bold = true },
  git_added = { fg = colors.green, bg = colors.base02, bold = true },
  git_changed = { fg = colors.yellow, bg = colors.base02, bold = true },
  git_removed = { fg = colors.red, bg = colors.base02, bold = true },
  git_sep = { fg = colors.base02, bg = statusline_bg }, 

  lsp_error = { fg = colors.base0F, bg = colors.base01 },
  lsp_warning = { fg = colors.base09, bg = colors.base01 },
  lsp_hints = { fg = colors.magenta, bg = colors.base01 },
  lsp_info = { fg = colors.green, bg = colors.base01 },
  lsp_progress = { fg = colors.green, bg = colors.base01 },
  lsp_sep = { fg = colors.red, bg = colors.base01 },
  lsp_icon = { fg = colors.black, bg = colors.red },
  lsp_text = { fg = colors.red, bg = colors.base01 },

  NormalMode = { bg = colors.blue, fg = colors.black, bold = true },
  InsertMode = { bg = colors.magenta, fg = colors.black, bold = true },
  TerminalMode = { bg = colors.green, fg = colors.black, bold = true },
  NTerminalMode = { bg = colors.yellow, fg = colors.black, bold = true },
  VisualMode = { bg = colors.cyan, fg = colors.black, bold = true },
  ReplaceMode = { bg = colors.orange, fg = colors.black, bold = true },
  ConfirmMode = { bg = colors.teal, fg = colors.black, bold = true },
  CommandMode = { bg = colors.green, fg = colors.black, bold = true },
  SelectMode = { bg = colors.blue, fg = colors.black, bold = true },

  NormalModeSep = { fg = colors.blue, bg = colors.base03 },
  InsertModeSep = { fg = colors.magenta, bg = colors.base03 },
  TerminalModeSep = { fg = colors.green, bg = colors.base03 },
  NTerminalModeSep = { fg = colors.yellow, bg = colors.base03 },
  VisualModeSep = { fg = colors.cyan, bg = colors.base03 },
  ReplaceModeSep = { fg = colors.orange, bg = colors.base03 },
  ConfirmModeSep = { fg = colors.teal, bg = colors.base03 },
  CommandModeSep = { fg = colors.green, bg = colors.base03 },
  SelectModeSep = { fg = colors.blue, bg = colors.base03 },

  buffer = { fg = colors.base03, bg = colors.base02 },

  file_info = { fg = colors.white, bg = colors.base02 },
  file_sep = { fg = colors.base02, bg = statusline_bg },
  cwd_icon = { fg = colors.black, bg = colors.red },
  cwd_text = { fg = colors.white, bg = colors.base02 },
  cwd_sep = { fg = colors.red, bg = statusline_bg },
  pos_sep = { fg = colors.green, bg = colors.base01 },
  pos_icon = { fg = colors.black, bg = colors.green },
  pos_text = { fg = colors.green, bg = colors.base01 },
}
