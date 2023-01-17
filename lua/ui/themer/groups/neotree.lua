local colors = require("ui.themer").colorscheme("vivid")

return {
  NeoTreeNormal = { bg = colors.base01 },
  NeoTreePreview = { bg = colors.base01 },
  NeoTreeFilterTerm = { bg = colors.base02 },
  NeoTreeWinSeparator = { bg = colors.base00, fg = colors.base00 },
  NeoTreeModified = { fg = colors.orange },
  NeoTreeTabActive = { bg = colors.base01 },
  NeoTreeTabInactive = { bg = colors.base00 },
  NeoTreeTabSeparatorActive = { bg = colors.base01, fg = colors.base01},
  NeoTreeTabSeparatorInactive = { bg = colors.base00, fg = colors.base00 },
}

