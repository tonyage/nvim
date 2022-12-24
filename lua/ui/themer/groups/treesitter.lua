local colors = require("ui.themer").colorscheme("vivid")

return {

  ["@annotation"] = { fg = colors.base0A, italic = true },
  ["@attribute"] = { fg = colors.base0A },
  ["@character"] = { fg = colors.base09 },
  ["@constructor"] = { fg = colors.base0A, bold = true },

  ["@constant"] = { fg = colors.base09 },
  ["@constant.builtin"] = { fg = colors.base09, italic = true },
  ["@constant.macro"] = { fg = colors.base09, bold = true },

  ["@define"] = { fg = colors.base0E, sp = "none" },
  ["@prepoc"] = { fg = colors.base0E },
  ["@repeat"] = { fg = colors.base0A },

  ["@error"] = { fg = colors.base0F },
  ["@exception"] = { fg = colors.base0F },

  ["@keyword"] = { fg = colors.base0E, bold = true, italic = true },
  ["@keyword.function"] = { fg = colors.base0E, bold = true, italic = true },
  ["@keyword.return"] = { fg = colors.base0E, bold = true, italic = true },
  ["@keyword.operator"] = { fg = colors.base0E },

  ["@function"] = { fg = colors.base0D },
  ["@function.builtin"] = { fg = colors.base0D, italic = true },
  ["@function.macro"] = { fg = colors.base0D, bold = true },

  ["@label"] = { fg = colors.base08, bold = true },
  ["@number"] = { fg = colors.base09 },
  ["@float"] = { link = "@number" },
  ["@boolean"] = { fg = colors.base0E, italic = true },

  ["@method"] = { fg = colors.base0D },
  ["@property"] = { fg = colors.base0C },
  ["@namespace"] = { fg = colors.base0E },
  ["@none"] = { fg = colors.base05 },
  ["@parameter"] = { fg = colors.base09 },
  ["@parameter.reference"] = { fg = colors.base07 },
  ["@reference"] = { fg = colors.base07 },

  ["@punctuation"] = { fg = colors.white },
  ["@punctuation.bracket"] = { fg = colors.white },
  ["@punctuation.special"] = { fg = colors.base08 },
  ["@operator"] = { fg = colors.base07, sp = "none" },

  ["@string"] = { fg = colors.base0B, italic = true },
  ["@string.regex"] = { fg = colors.base09 },
  ["@string.escape"] = { fg = colors.base08 },
  ["@structure"] = { fg = colors.base0E, bold = true },
  ["@storageclass"] = { fg = colors.base0A },

  ["@symbol"] = { fg = colors.base0C },

  ["@tag"] = { fg = colors.base0A },
  ["@tag.attribute"] = { link = "@property" },
  ["@tag.delimiter"] = { fg = colors.base0F },

  ["@text"] = { fg = colors.base07 },
  ["@text.strong"] = { bold = true },
  ["@text.emphasis"] = { fg = colors.base09, italic = true },
  ["@text.strike"] = { fg = colors.base00, strikethrough = true },
  ["@text.literal"] = { fg = colors.base0B, italic = true },
  ["@text.uri"] = { fg = colors.base09, underline = true },
  ["@test.reference"] = { fg = colors.base09 },
  ["@text.todo"] = { fg = colors.base09, bg = colors.base00 },

  ["@type"] = { fg = colors.base0A, sp = "none", bold = true },
  ["@type.builtin"] = { fg = colors.base09 },
  ["@type.defintion"] = { fg = colors.base0A, sp = "none", bold = true, italic = true },

  ["@variable"] = { fg = colors.base07 },
  ["@variable.builtin"] = { fg = colors.base09 },

  ["@definition"] = { fg = colors.base07, underline = true },
  ["@scope"] = { bold = true },
  ["@field"] = { fg = colors.red },
  ["@include"] = { fg = colors.base0E, italic = true },
  ["@conditional"] = { fg = colors.base0E, italic = true },
}

