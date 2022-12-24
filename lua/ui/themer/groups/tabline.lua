local colors = require("ui.themer").colorscheme("vivid")
return {
  TbLineFill = { bg = colors.base01 },
  TbLineBufOn = { fg = colors.white, bg = colors.black },
  TbLineBufOff = { fg = colors.white, bg = colors.base02 },
  TbLineBufOnModified = { fg = colors.green, bg = colors.black },
  TbBufLineBufOffModified = { fg = colors.red, bg = colors.base02 },
  TbLineBufOnClose = { fg = colors.red, bg = colors.black },
  TbLineBufOffClose = { fg = colors.grey01, bg = colors.base02 },
  TblineTabNewBtn = { fg = colors.white, bg = colors.base03, bold = true },
  TbLineTabOn = { bold = true, fg = colors.black, bg = colors.blue },
  TbLineTabOff = { fg = colors.white, bg = colors.base02 },
  TbLineTabCloseBtn = { fg = colors.black, bg = colors.blue },
  TbTabTitle = { fg = colors.black, bg = colors.white },
  TbLineCloseAllBufsBtn = { bold = true, bg = colors.red, fg = colors.black },
}

