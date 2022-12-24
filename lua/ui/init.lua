require("ui.themer").load()
require("ui.terminal").setup()

vim.opt.statusline = "%!v:lua.require('ui.statusline').setup()"
require("ui.tabline.lazy")({ lazyload = true })
require("ui.winbar")
