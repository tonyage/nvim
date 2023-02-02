local colors = require("ui.themer").colorscheme("vivid")

return {
  IndentBlanklineChar = { fg = colors.base01 },
  IndentBlanklineSpaceChar = { fg = colors.base01 },
  IndentBlanklineContextChar = { fg = colors.magenta },
  IndentBlanklineContextStart = { bg = colors.base00 },
}
