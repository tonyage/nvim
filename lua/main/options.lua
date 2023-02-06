vim.g.mapleader = " "
vim.g.colorscheme = "dusk"
vim.g.statusline_style = "default"

vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.tabstop = 2
-- vim.opt.softtabstop = 2
vim.opt.cursorcolumn = true
vim.opt.cursorline = true
vim.opt.laststatus = 3

vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.linebreak = true
vim.opt.swapfile = false
vim.opt.textwidth = 99
vim.opt.virtualedit = "block"
vim.opt.wrap = true
vim.opt.showmode = false

vim.opt.signcolumn = "yes"
vim.opt.number = true
vim.opt.numberwidth = 2
vim.opt.relativenumber = true
vim.opt.ruler = false

vim.opt.mouse = "a"
vim.opt.mousemoveevent = true

vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.termguicolors = true

vim.opt.backup = false
vim.opt.writebackup = false

-- vim.opt.list = true
-- vim.opt.listchars:append "space: "
-- vim.opt.listchars:append "eol:↴"
vim.opt.updatetime = 300
vim.opt.cmdheight = 1
vim.opt.whichwrap:append "<>[]hl"
vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver100,a:blinkon100"

vim.opt.fillchars = {
  eob = " ",
  vertright = " ",
}

local disabled_plugins = {
  "netrw",
  "netrwPlugin"
}

for _, plugin in pairs(disabled_plugins) do
  vim.g[ "loaded_" .. plugin ] = 1
end
