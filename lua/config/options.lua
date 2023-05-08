-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options her
vim.g.mapleader = " "
vim.opt.autoindent = true
vim.opt.backup = false
vim.opt.cmdheight = 1
vim.opt.cursorcolumn = true
vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver100,a:blinkon100"
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.laststatus = 3
vim.opt.linebreak = true
vim.opt.mousemev = true
vim.opt.number = true
vim.opt.numberwidth = 2
vim.opt.ruler = false
vim.opt.softtabstop = 2
vim.opt.swapfile = false
vim.opt.textwidth = 119
vim.opt.updatetime = 300
vim.opt.virtualedit = "block"
vim.opt.whichwrap:append("<>[]hl")
vim.opt.wrap = true
vim.opt.writebackup = false

vim.o.winbar = "%{%v:lua.require('nvim-navic').get_location()%}"
