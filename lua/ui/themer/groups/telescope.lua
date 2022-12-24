local colors = require("ui.themer").colorscheme("vivid")

return {
  TelescopeBorder = { fg = colors.grey02, bg = colors.base00 },
  TelescopePromptBorder = { fg = colors.grey02, bg = colors.base00 },
  TelescopePromptNormal = { fg = colors.white, bg = colors.base00 },
  TelescopePromptPrefix = { fg = colors.red, bg = colors.base00 },

  TelescopeNormal = { bg = colors.base00 },

  TelescopePromptTitle = { fg = colors.black, bg = colors.red },
  TelescopePreviewTitle = { fg = colors.black, bg = colors.green },
  TelescopeResultsTitle = { fg = colors.black, bg = colors.blue },

  TelescopeSelection = { bg = colors.base01, fg = colors.white },

  TelescopeResultsDiffAdd = { fg = colors.green },
  TelescopeResultsDiffChange = { fg = colors.yellow },
  TelescopeResultsDiffDelete = { fg = colors.red },
}
