local colors = require("ui.themer").colorscheme("vivid")

return {
  TelescopeTitle = { bg = colors.base01 },
  TelescopeBorder = { bg = colors.base02 },
  TelescopeNormal = { bg = colors.base01 },

  TelescopeSelection = { bg = colors.base02, fg = colors.white },
  TelescopeSelectionCaret = { fg = colors.green },

  TelescopePromptTitle = { fg = colors.black, bg = colors.green },
  TelescopePromptPrefix = { fg = colors.green, bg = colors.base02 },
  TelescopePromptBorder = { fg = colors.base02, bg = colors.base02 },
  TelescopePromptNormal = { fg = colors.white, bg = colors.base02 },

  TelescopePreviewMatch = { bg = colors.base02 },
  TelescopePreviewLine = { bg = colors.base02 },
  TelescopePreviewTitle = { fg = colors.black, bg = colors.blue },
  TelescopePreviewBorder = { fg = colors.base01, bg = colors.base01 },
  TelescopePreviewNormal = { fg = colors.white, bg = colors.base01 },

  TelescopeResultsTitle = { fg = colors.black, bg = colors.red },
  TelescopeResultsBorder = { fg = colors.base01, bg = colors.base01 },
  TelescopeResultsNormal = { fg = colors.white, bg = colors.base01 },

  TelescopeResultsDiffAdd = { fg = colors.green },
  TelescopeResultsDiffChange = { fg = colors.yellow },
  TelescopeResultsDiffDelete = { fg = colors.red },
}
