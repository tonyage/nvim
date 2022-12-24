local navic = require("nvim-navic")
local winbar = require('ui.winbar.sections')
local lspkind = require("ui.icons")["lspkind"]

local config = {
  icons = {
    File          = " ",
    Module        = lspkind["Module"],
    Namespace     = " ",
    Package       = " ",
    Class         = lspkind["Class"],
    Method        = " ",
    Property      = "練",
    Field         = " ",
    Constructor   = " ",
    Enum          = lspkind["Enum"],
    Interface     = lspkind["Interface"],
    Function      = " ",
    Variable      = " ",
    Constant      = " ",
    String        = " ",
    Number        = " ",
    Boolean       = "◩ ",
    Array         = " ",
    Object        = " ",
    Key           = " ",
    Null          = "ﳠ ",
    Struct        = lspkind["Struct"],
    Event         = " ",
    Operator      = " ",
    TypeParameter = " ",
  },
  highlight = true,
  separator = " " .. require("ui.icons").winbar["separator"]["light"]["right"] .. " ",
}

navic.setup(config)

vim.api.nvim_create_autocmd({ 'DirChanged', 'CursorMoved', 'BufWinEnter', 'BufFilePost', 'InsertEnter', 'BufWritePost' }, {
  callback = function()
    local present, _ = pcall(vim.api.nvim_buf_get_var, 0, "lsp_floating_window")
      if not present then
        winbar.create()
      end
  end
})

winbar.create()

