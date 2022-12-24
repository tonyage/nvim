local M = {}

function M.colorscheme(variant)
  local path = "ui.themer.colorschemes." .. vim.g.colorscheme
  local colorscheme = require(path)
  return colorscheme[variant]
end

function M.new_hl_groups(group1, group2, group3)
  local fg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID(group2)), "fg#")
  local bg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID(group3)), "bg#")
  vim.api.nvim_set_hl(0, group1 .. group2 .. group3, { fg = fg, bg = bg })
  return "%#" .. group1 .. group2 .. group3 .. "#"
end

function M.highlight(group)
  group = require("ui.themer.groups." .. group)
  for k, v in pairs(group) do
    vim.api.nvim_set_hl(0, k, v)
  end
end

function M.load()
  local groups = { "base", "statusline" }
  for _, group in pairs(groups) do
    M.highlight(group)
  end
end

return M

