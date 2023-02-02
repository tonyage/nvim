local colors = require("ui.themer").colorscheme("vivid")
return {
  LazyTaskError = { fg = colors.base0F },
  LazyProgressDone = { fg = colors.blue },
  LazyProgressTodo = { fg = colors.blue },
  LazyProp = { fg = colors.magenta },
  LazyReasonEvent = { fg = colors.blue },
  LazyReasonPlugin = { fg = colors.orange },
  LazyReasonFt = { fg = colors.cyan },
  LazyReasonImport = { fg = colors.magenta },
  LazyReasonSource = { fg = colors.yellow },
}

