local M = {}
require("ui.themer").highlight("winbar")
local devicons = require("nvim-web-devicons")
local separator = require("ui.icons").winbar["separator"]

local hl_winbar_path = "WinbarPath"
local hl_winbar_symbols = "WinbarSymbols"
local hl_icon = "WinbarFileIcon"

local is_empty = function(s)
  return s == nil or s == ""
end

local exclude_filetypes = {
  'help',
  'NvimTree',
  'alpha',
  'toggleterm',
}

local file_info = function()
  local path = vim.fn.expand("%:~:.:h")
  local name = vim.fn.expand("%:t")
  local file_type = vim.fn.expand("%:e")
  local value = " "

  path = path:gsub("^%.", "")
  path = path:gsub("^%/", "")

  if not is_empty(name) then
    local default = false

    if is_empty(file_type) then
      file_type = ""
      default = true
    end

    local icon = devicons.get_icon(name, file_type, { default = default })

    if not icon then
      icon = devicons.get_icon("default_icon")
    end

    hl_icon = "DevIcon" .. file_type
    icon = "%#" .. hl_icon .. "#" .. icon .. " %*"

    local path_list = {}
    local _ = string.gsub(path, '[^/]+', function(w)
      table.insert(path_list, w)
    end)

    for i = 1, #path_list do
      value = value .. "%#" .. hl_winbar_path .. "#" .. path_list[i] .. " " .. separator["light"]["right"] .. " %*"
    end
    value = value .. icon
    value = value .. "%#" .. hl_winbar_path .. "#" .. name .. "%*"
  end
  return value
end

local gps = function()
  local ok, nav = pcall(require, "nvim-navic")
  local _, gps_location = pcall(nav.get_location, {})
  local location = " "

  if ok and nav.is_available() and gps_location ~= "error" and not is_empty(gps_location) then
    location = "%#" .. hl_winbar_symbols .. "# " .. separator["light"]["right"] .. " %*"
    location = location .. '%#' .. hl_winbar_symbols .. "#"  .. gps_location .. "%*"
  end
  return location
end

local excludes = function()
  local exclude = false
  if vim.tbl_contains(exclude_filetypes, vim.bo.filetype) then
    vim.opt_local.winbar = nil
    exclude = true
  end
  return exclude
end

M.create = function()
  if excludes() then return end

  local value = file_info()
  if not is_empty(value) then
    value = value .. gps()
  end

  local num_tabs = #vim.api.nvim_list_tabpages()

  if num_tabs > 1 and not is_empty(value) then
    local tabpage_number = tostring(vim.api.nvim_tabpage_get_number(0))
    value = value .. "%=" .. tabpage_number .. "/" .. tostring(num_tabs)
  end


  local status_ok, _ = pcall(vim.api.nvim_set_option_value, 'winbar', value, { scope = 'local' })
  if not status_ok then
      return
  end
end

return M

